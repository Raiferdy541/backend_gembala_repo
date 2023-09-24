'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('d_riwayat_fattening', {
      id_riwayat_fattening: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      id_peternakan: {
        type: Sequelize.INTEGER
      },
      rf_id: {
        type: Sequelize.STRING
      },
      id_ternak: {
        type: Sequelize.INTEGER
      },
      id_kandang: {
        type: Sequelize.INTEGER
      },
      bobot_tahap_1: {
        type: Sequelize.INTEGER
      },
      bobot_tahap_2: {
        type: Sequelize.INTEGER
      },
      bobot_tahap_3: {
        type: Sequelize.INTEGER
      },
      status_keluar: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('d_riwayat_fattening');
  }
};