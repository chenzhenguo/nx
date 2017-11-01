//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package org.jeecgframework.web.cgreport.service.impl.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.cgreport.dao.core.CgReportDao;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigHeadEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigParamEntity;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("cgReportService")
@Transactional
public class CgReportServiceImpl extends CommonServiceImpl implements CgReportServiceI {
    @Autowired
    private JdbcDao jdbcDao;
    @Autowired
    private CgReportDao cgReportDao;

    public CgReportServiceImpl() {
    }

    public Map<String, Object> queryCgReportConfig(String reportId) {
        Map<String, Object> cgReportM = new HashMap(0);
        Map<String, Object> mainM = this.queryCgReportMainConfig(reportId);
        List<Map<String, Object>> itemsM = this.queryCgReportItems(reportId);
        List<String> params = this.queryCgReportParam(reportId);
        cgReportM.put("main", mainM);
        cgReportM.put("items", itemsM);
        cgReportM.put("params", params);
        return cgReportM;
    }

    public Map<String, Object> queryCgReportMainConfig(String reportId) {
        return this.cgReportDao.queryCgReportMainConfig(reportId);
    }

    public List<Map<String, Object>> queryCgReportItems(String reportId) {
        return this.cgReportDao.queryCgReportItems(reportId);
    }

    public List<String> queryCgReportParam(String reportId) {
        List<String> list = null;
        CgreportConfigHeadEntity cgreportConfigHead = (CgreportConfigHeadEntity)this.findUniqueByProperty(CgreportConfigHeadEntity.class, "code", reportId);
        String hql0 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
        List<CgreportConfigParamEntity> cgreportConfigParamList = this.findHql(hql0, new Object[]{cgreportConfigHead.getId()});
        if(cgreportConfigParamList != null & cgreportConfigParamList.size() > 0) {
            list = new ArrayList();
            Iterator var7 = cgreportConfigParamList.iterator();

            while(var7.hasNext()) {
                CgreportConfigParamEntity cgreportConfigParam = (CgreportConfigParamEntity)var7.next();
                list.add(cgreportConfigParam.getParamName());
            }
        }

        return list;
    }

    public List<Map<String, Object>> queryByCgReportSql(String sql, Map params, int page, int rows) {
        String querySql = this.getFullSql(sql, params);
        List<Map<String, Object>> result = null;
        if(page == -1 && rows == -1) {
            result = this.jdbcDao.findForJdbc(querySql, new Object[0]);
        } else {
            result = this.jdbcDao.findForJdbc(querySql, page, rows);
        }

        return result;
    }

    private String getFullSql(String sql, Map params) {
        StringBuilder sqlB = new StringBuilder();
        sqlB.append("SELECT t.* FROM ( ");
        sqlB.append(sql + " ");
        sqlB.append(") t ");
        if(params.size() >= 1) {
            sqlB.append("WHERE 1=1  ");
            Iterator it = params.keySet().iterator();

            while(it.hasNext()) {
                String key = String.valueOf(it.next());
                String value = String.valueOf(params.get(key));
                if(!StringUtil.isEmpty(value) && !"null".equals(value)) {
                    sqlB.append(" AND ");
                    sqlB.append(" " + key + value);
                }
            }
        }

        return sqlB.toString();
    }

    public long countQueryByCgReportSql(String sql, Map params) {
        String querySql = this.getFullSql(sql, params);
        querySql = "SELECT COUNT(*) FROM (" + querySql + ") t2";
        long result = this.jdbcDao.findForLong(querySql, new HashMap(0));
        return result;
    }

    public List<String> getSqlFields(String sql) {
        if(oConvertUtils.isEmpty(sql)) {
            return null;
        } else {
            List<Map<String, Object>> result = this.jdbcDao.findForJdbc(sql, 1, 1);
            if(result.size() < 1) {
                throw new BusinessException("该报表sql没有数据");
            } else {
                Set fieldsSet = ((Map)result.get(0)).keySet();
                List<String> fileds = new ArrayList(fieldsSet);
                return fileds;
            }
        }
    }
}