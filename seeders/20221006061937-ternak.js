'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('s_ternak', [
    {
      rf_id: 'RFID 1',
      foto: 'Foto 1',
      jenis_kelamin: 'Betina',
      id_varietas: 1,
      id_kandang: 1,
      id_pakan: 1,
      id_fp: 1,
      id_induk: null,
      id_pejantan: null,
      berat: 100,
      suhu: 100,
      status_kesehatan: 'Sehat',
      id_penyakit: null,
      tanggal_lahir: new Date(),
      tanggal_masuk: new Date(),
      tanggal_keluar: null,
      status_keluar: null,
    },
    {
      rf_id: 'RFID 2',
      foto: 'Foto 2',
      jenis_kelamin: 'Jantan',
      id_varietas: 2,
      id_kandang: 2,
      id_pakan: 2,
      id_fp: 2,
      id_induk: null,
      id_pejantan: null,
      berat: 100,
      suhu: 100,
      status_kesehatan: 'Sehat',
      id_penyakit: null,
      tanggal_lahir: new Date(),
      tanggal_masuk: new Date(),
      tanggal_keluar: null,
      status_keluar: null,
    },
    {
      rf_id: 'RFID 3',
      foto: 'Foto 3',
      jenis_kelamin: 'Betina',
      id_varietas: 1,
      id_kandang: 1,
      id_pakan: 1,
      id_fp: 1,
      id_induk: 1,
      id_pejantan: 2,
      berat: 100,
      suhu: 100,
      status_kesehatan: 'Sehat',
      id_penyakit: null,
      tanggal_lahir: new Date(),
      tanggal_masuk: new Date(),
      tanggal_keluar: null,
      status_keluar: null,
    },
    {
      rf_id: 'RFID 4',
      foto: 'Foto 4',
      jenis_kelamin: 'Jantan',
      id_varietas: 1,
      id_kandang: 1,
      id_pakan: 1,
      id_fp: 1,
      id_induk: 1,
      id_pejantan: 2,
      berat: 100,
      suhu: 100,
      status_kesehatan: 'Sehat',
      id_penyakit: null,
      tanggal_lahir: new Date(),
      tanggal_masuk: new Date(),
      tanggal_keluar: null,
      status_keluar: null,
    },
  ], {});
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('s_ternak', null, {});
  }
};
