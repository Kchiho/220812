package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import util.JDBCUtil;
import vo.BoardVO;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	final String sql_selectOne="SELECT B.*, M.MNAME FROM BOARD B, MEMBER M WHERE B.WRITER = M.MID(+) AND B.BID=?";
	final String sql_selectAll="SELECT * FROM BOARD";
	final String sql_selectAllw="SELECT B.*, M.MNAME FROM (SELECT * FROM MEMBER WHERE MNAME LIKE '%'||?||'%') M, BOARD B WHERE B.WRITER = M.MID ORDER BY B.BID DESC";
	final String sql_selectAllt="SELECT B.*, M.MNAME FROM (SELECT * FROM BOARD WHERE TITLE LIKE '%'||?||'%') B, MEMBER M WHERE B.WRITER = M.MID(+) ORDER BY B.BID DESC";
	final String sql_insert="INSERT INTO BOARD VALUES((SELECT NVL(MAX(BID),0) +1 FROM BOARD),?,?,?,0,0,(SELECT SYSDATE FROM DUAL))";
	final String sql_update="UPDATE BOARD SET TITLE=?,CONTENT=? WHERE BID=?";
	final String sql_updateR="UPDATE BOARD SET BREAD=BREAD+1 WHERE BID=?";
	final String sql_updateLu="UPDATE BOARD SET BLIKE=BLIKE+1 WHERE BID=?";
	final String sql_updateLd="UPDATE BOARD SET BLIKE=BLIKE-1 WHERE BID=?";
	final String sql_delete="DELETE FROM BOARD WHERE BID=?";
	//final String sql_join="SELECT B.*, M.MNAME FROM BOARD B, MEMBER M WHERE B.WRITER = M.MID ORDER BY B.BID DESC";
	final String sql_join="SELECT B.*, M.MNAME FROM BOARD B, MEMBER M WHERE B.WRITER = M.MID(+) ORDER BY B.BID DESC";

	public BoardVO selectOne(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectOne);
			pstmt.setInt(1, vo.getBid());
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				if(rs.getString("MNAME") != null) {
					data.setWriter(rs.getString("MNAME"));
				}else {
					data.setWriter("알수없음");
				}
				data.setBread(rs.getInt("BREAD"));
				data.setBlike(rs.getInt("BLIKE"));
				data.setBdate(rs.getString("BDATE"));
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
	public ArrayList<BoardVO> selectAll(BoardVO vo){
		ArrayList<BoardVO> datas=new ArrayList<BoardVO>();
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectAll);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				data.setWriter(rs.getString("WRITER"));
				datas.add(data);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}		
		return datas;
	}
	public ArrayList<BoardVO> join(BoardVO vo){
		ArrayList<BoardVO> datas=new ArrayList<BoardVO>();
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_join);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setTitle(rs.getString("TITLE"));
				data.setContent(rs.getString("CONTENT"));
				if(rs.getString("MNAME") != null) {
					data.setWriter(rs.getString("MNAME"));
				}else {
					data.setWriter("알수없음");
				}
				data.setBread(rs.getInt("BREAD"));
				data.setBlike(rs.getInt("BLIKE"));
				data.setBdate(rs.getString("BDATE"));
				datas.add(data);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}		
		return datas;
	}
	public ArrayList<BoardVO> selectAlls(BoardVO vo){
		ArrayList<BoardVO> datas=new ArrayList<BoardVO>();
		conn=JDBCUtil.connect();
		try {
			if(vo.getWriter() != null) {
				pstmt=conn.prepareStatement(sql_selectAllw);
				pstmt.setString(1, vo.getWriter());			
			}
			else {
				pstmt=conn.prepareStatement(sql_selectAllt);
				pstmt.setString(1, vo.getTitle());					
			}
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				if(rs.getString("MNAME") != null) {
					data.setWriter(rs.getString("MNAME"));
				}else {
					data.setWriter("알수없음");
				}
				data.setBread(rs.getInt("BREAD"));
				data.setBlike(rs.getInt("BLIKE"));
				data.setBdate(rs.getString("BDATE"));
				datas.add(data);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}		
		return datas;
	}
	public boolean insert(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getWriter());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean update(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean updateR(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_updateR);
			pstmt.setInt(1,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean updateLu(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_updateLu);
			pstmt.setInt(1,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean updateLd(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_updateLd);
			pstmt.setInt(1,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean delete(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_delete);
			pstmt.setInt(1,vo.getBid());
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
