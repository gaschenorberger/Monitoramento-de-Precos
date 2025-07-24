import React, { useState, useRef, useEffect } from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Tooltip,
  Legend,
} from 'chart.js';
import { Line } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Tooltip,
  Legend
);

// Simulação de dados da API (igual ao seu)
const allData = {
  '30d': [
    { date: '23 jun', price: 8896 },
    { date: '30 jun', price: 8896 },
    { date: '05 jul', price: 8896 },
    { date: '09 jul', price: 8639 },
    { date: '15 jul', price: 8896 },
    { date: '20 jul', price: 8896 },
  ],
  '6m': [
    { date: '22 jan', price: 9896 },
    { date: '22 fev', price: 9496 },
    { date: '22 mar', price: 9196 },
    { date: '22 abr', price: 8996 },
    { date: '22 mai', price: 8896 },
    { date: '22 jun', price: 8639 },
  ],
  '1y': [
    { date: 'jul 2024', price: 9996 },
    { date: 'out 2024', price: 9796 },
    { date: 'jan 2025', price: 9496 },
    { date: 'abr 2025', price: 8896 },
    { date: 'jul 2025', price: 8639 },
  ],
};

export default function PriceHistoryChart() {
  const [selectedRange, setSelectedRange] = useState('30d');

  const handleChangeRange = (range) => {
    setSelectedRange(range);
  };

  const dataForChart = allData[selectedRange];
  const labels = dataForChart.map((item) => item.date);
  const prices = dataForChart.map((item) => item.price);

  const data = {
    labels,
    datasets: [
      {
        label: 'Preço (R$)',
        data: prices,
        fill: false,
        borderColor: '#ff00cc',
        backgroundColor: '#ff00cc',
        tension: 0.4,
        pointRadius: 4,
        pointHoverRadius: 6,
        borderWidth: 3,
      },
    ],
  };

  const options = {
    responsive: true,
    interaction: {
      mode: 'nearest',
      intersect: false,
    },
    scales: {
      y: {
        beginAtZero: false,
        ticks: {
          // Formatar ticks para exibir R$ com duas casas decimais
          callback: function (value) {
            return `R$ ${value.toFixed(2)}`;
          },
        },
      },
    },
    plugins: {
      tooltip: {
        callbacks: {
          label: function (context) {
            const value = context.parsed.y;
            return `R$ ${value.toFixed(2)}`;
          },
        },
      },
      legend: {
        display: false, // para ficar igual ao seu, escondendo legenda
      },
    },
  };

  return (
    <div style={{ width: '100%', maxWidth: 700, margin: 'auto' }}>
      <h3 style={{ marginBottom: '10px' }}>Histórico de preços</h3>

      <div style={{ marginBottom: '20px' }}>
        <button
          onClick={() => handleChangeRange('30d')}
          style={selectedRange === '30d' ? selectedStyle : buttonStyle}
        >
          30 dias
        </button>
        <button
          onClick={() => handleChangeRange('6m')}
          style={selectedRange === '6m' ? selectedStyle : buttonStyle}
        >
          6 meses
        </button>
        <button
          onClick={() => handleChangeRange('1y')}
          style={selectedRange === '1y' ? selectedStyle : buttonStyle}
        >
          1 ano
        </button>
      </div>

         <Line data={data} options={options} />
    </div>
  );
}

const buttonStyle = {
  padding: '8px 12px',
  marginRight: '10px',
  border: '1px solid #ccc',
  borderRadius: '8px',
  background: 'white',
  cursor: 'pointer',
};

const selectedStyle = {
  ...buttonStyle,
  background: '#ff00cc',
  color: 'white',
  border: '1px solid #ff00cc',
};
