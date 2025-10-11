package service;

import Dao.ClinicInfoDao;
import model.ClinicInfo;

import java.util.List;

public class ClinicInfoService {
    private final ClinicInfoDao clinicInfoDao;
    private static ClinicInfoService clinicInfoService;

    private ClinicInfoService() {
        this.clinicInfoDao = ClinicInfoDao.getInstance();
    }

    // Singleton: chỉ có 1 instance của Service
    public static ClinicInfoService getInstance() {
        if (clinicInfoService == null) {
            clinicInfoService = new ClinicInfoService();
        }
        return clinicInfoService;
    }

    // Lấy tất cả thông tin phòng khám
    public List<ClinicInfo> findAll() {
        return clinicInfoDao.findAll();
    }

    // Thêm mới phòng khám
    public ClinicInfo addClinicInfo(ClinicInfo clinicInfo) {
        return clinicInfoDao.addClinicInfo(clinicInfo);
    }

    // Cập nhật phòng khám
    public boolean updateClinicInfo(ClinicInfo clinicInfo) {
        return clinicInfoDao.updateClinicInfo(clinicInfo);
    }

    // Xóa phòng khám theo ID
    public boolean deleteClinicInfo(int clinic_id) {
        return clinicInfoDao.deleteClinicInfo(clinic_id);
    }
}
