import "./style.css"
import { useEffect, useState } from 'react';

export default function ProductGuide() {
    const [active, setActive] = useState('compare');

    const handleScrollTo = (id) => {
        const element = document.getElementById(id);
        if (element) {
            element.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    };

    useEffect(() => {
        const sections = ['compare', 'descricao', 'ficha'];
        const observer = new IntersectionObserver(
            (entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        setActive(entry.target.id);
                    }
                });
            },
            { threshold: 0.6 }
        );

        sections.forEach((id) => {
            const section = document.getElementById(id);
            if (section) observer.observe(section);
        });

        return () => observer.disconnect();
    }, []);

    return (
        <div className="guideButtons stickyGuide">
            <button className={active === 'compare' ? 'active' : ''} onClick={() => handleScrollTo('compare')}>
                Compare os preços
            </button>
            <button className={active === 'descricao' ? 'active' : ''} onClick={() => handleScrollTo('descricao')}>
                Descrição
            </button>
            <button className={active === 'ficha' ? 'active' : ''} onClick={() => handleScrollTo('ficha')}>
                Ficha Técnica
            </button>
            <button>Avaliações</button>
        </div>
    );
}
