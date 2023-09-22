'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('d_fattening', {
      id_fattening: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true
      },
      id_peternakan: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'd_peternakan',
          key: 'id_peternakan'
        },
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      rf_id: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      id_ternak: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 's_ternak',
          key: 'id_ternak'
        },
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      id_kandang: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'd_kandang',
          key: 'id_kandang'
        },
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      bobot_fattening: {
        type: Sequelize.INTEGER,
        allowNull: true
      },
      tahap_fattening: {
        type: Sequelize.INTEGER,
        allowNull: true
      },
      keterangan:{
        type: Sequelize.ENUM,
        values: [
          'Terpenuhi',
          'Tidak Terpenuhi'
        ],
        allowNull: true
      },
      status_keluar: {
        type: Sequelize.STRING,
        allowNull: true
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP')
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('d_fattening');
  }
};