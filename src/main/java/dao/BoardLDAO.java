package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.JDBCUtil;
import vo.BoardLVO;
import vo.BoardVO;
import vo.MemberVO;

public class BoardLDAO {
	Connection conn;
	PreparedStatement pstmt;
	
	private String sql_selectOne = "SELECT * FROM BOARDL WHERE BID=? AND MID=?";
	private String sql_insert = "INSERT INTO BOARDL VALUES (?,?,1)";
	private String sql_update = "UPDATE BOARDL SET CHECKL=? WHERE BID=? AND MID=?";
	
	public BoardLVO selectOne(BoardVO bvo, MemberVO mvo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectOne);
			pstmt.setInt(1, bvo.getBid());
			pstmt.setString(2, mvo.getMid());
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				BoardLVO data=new BoardLVO();
				data.setBid(rs.getInt("BID"));
				data.setMid(rs.getString("MID"));
				data.setCheckL(rs.getInt("CHECKL"));
				return data;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}		
		return null;
	}
	public boolean insert(BoardVO bvo, MemberVO mvo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setInt(1, bvo.getBid());
			pstmt.setString(2, mvo.getMid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean update(BoardLVO vo,BoardVO bvo, MemberVO mvo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_update);
			if(vo.getCheckL() == 1) {
				pstmt.setInt(1, 0);
			}else {
				pstmt.setInt(1, 1);				
			}
			pstmt.setInt(2, bvo.getBid());
			pstmt.setString(3, mvo.getMid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
}
