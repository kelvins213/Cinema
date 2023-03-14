import 'package:cinema/domain/film.dart';
import 'package:cinema/domain/costumer.dart';

class CinemaContents{

  static Film film1 = Film(thumbLink: "https://cinema10.com.br/upload/filmes/filmes_11775_29239d6e-2fb6-40ae-8f5d-1a1b70c3e681.jpg", film: "Doctor Strange", synopsis: "Após sua carreira ser destruída, um brilhante, porém arrogante, cirurgião ganha uma nova chance em sua vida quando um feiticeiro o treina para se tornar o Mago Supremo.", date: "15/10/2023", time: "15:00");
  static Film film2 = Film(thumbLink: "https://br.web.img2.acsta.net/pictures/20/10/06/18/20/0630056.jpg", film: "Mortal", synopsis: "Um mochileiro viajando pela Noruega acaba preso pela morte de um garoto local. Durante sua detenção, uma psicóloga tenta entender o que aconteceu. Lentamente, o jovem começa a perceber que sua história se mistura com a mitologia nórdica.", date: "15/10/2023", time: "15:00");
  static Film film3 = Film(thumbLink: "https://sm.ign.com/ign_br/screenshot/default/screenshot-nr21_ykjc.png", film: "Avangers", synopsis: "Após Thanos eliminar metade das criaturas vivas, os Vingadores têm de lidar com a perda de amigos e entes queridos. Com Tony Stark vagando perdido no espaço sem água e comida, Steve Rogers e Natasha Romanov lideram a resistência contra o titã louco.", date: "15/10/2023", time: "15:00");
  static Film film4 = Film(thumbLink: "https://lumiere-a.akamaihd.net/v1/images/56015l10_bigsal_brazil_intpayoff_4x5_d4019af6.jpeg", film: "Thor", synopsis: "Loki, o irmão de Thor, ganha acesso ao poder ilimitado do cubo cósmico ao roubá-lo de dentro das instalações da S.H.I.E.L.D. Nick Fury, o diretor desta agência internacional que mantém a paz, logo reúne os únicos super-heróis que serão capazes de defender a Terra de ameaças sem precedentes. Homem de Ferro, Capitão América, Hulk, Thor, Viúva Negra e Gavião Arqueiro formam o time dos sonhos de Fury, mas eles precisam aprender a colocar os egos de lado e agir como um grupo em prol da humanidade.", date: "15/10/2023", time: "15:00");
  static Film film5 = Film(thumbLink: "https://cinema10.com.br/upload/featuredImage.php?url=https%3A%2F%2Fcinema10.com.br%2Fupload%2Ffilmes%2Ffilmes_13855_filmes_13855_3776523.jpg-r_1920_1080-f_jpg-q_x-xxyxx.jpg", film: "Evil's Doll", synopsis: "Cynthia Kyle enters puberty with a vengeance, murdering her parents as they make love: she’s wanted her father to love only her. Eight years later, she’s free and wants to marry, but nightmares plague her so she seeks psychiatric help.", date: "15/10/2023", time: "15:00");
  static Film film6 = Film(thumbLink: "https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg", film: "Ultimate ", synopsis: "Após Thanos eliminar metade das criaturas vivas, os Vingadores têm de lidar com a perda de amigos e entes queridos. Com Tony Stark vagando perdido no espaço sem água e comida, Steve Rogers e Natasha Romanov lideram a resistência contra o titã louco.", date: "15/10/2023", time: "15:00");
  static Film film7 = Film(thumbLink: "https://br.web.img3.acsta.net/pictures/19/04/03/18/23/2539612.jpg", film: "The Joker", synopsis: "Isolado, intimidado e desconsiderado pela sociedade, o fracassado comediante Arthur Fleck inicia seu caminho como uma mente criminosa após assassinar três homens em pleno metrô. Sua ação inicia um movimento popular contra a elite de Gotham City, da qual Thomas Wayne é seu maior representante.", date: "15/10/2023", time: "15:00");
  static Film film8 = Film(thumbLink: "https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/8C9E09764AA2C055E1074C0BDDCC7C8091D619EDB349F43122D6F54A853E91B6/scale?width=506&aspectRatio=2.00&format=jpeg", film: "Megan Leavey", synopsis: "A agente da marinha norte-americana Megan Leavey é uma especialista em treinamento de cães para detectar bombas. Ela é enviada ao Iraque, onde forma uma boa parceria com o cão Rex. No entanto, Megan é ferida e afastada do campo de batalha. Enquanto isso, o cão permanece em atividade, e ela espera a aposentadoria do animal para poder adotá-lo. Antes desse prazo, a ex-agente descobre que o cachorro sofrerá uma eutanásia e luta para reverter essa decisão.", date: "15/10/2023", time: "15:00");

  static User user = User(email: "kelvin@gmail.com", password: "123456");

  static List<Film> films = [
    film1,
    film2,
    film3,
    film4,
    film5,
    film6,
    film7,
    film8
  ];

}