import 'package:cached_network_image/cached_network_image.dart';
import '../../src/controllers/category_controller.dart';
import '../../src/controllers/product_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../src/models/category.dart';
import '../../src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryGridWidget extends StatefulWidget {
  final List<Category> categories;

  const CategoryGridWidget({
    Key key,
    this.categories,
  }) : super(key: key);

  @override
  _CategoryGridWidget createState() => _CategoryGridWidget();
}

class _CategoryGridWidget extends StateMVC<CategoryGridWidget> {

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 15),
      crossAxisCount:
      MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
      itemCount: widget.categories.length,
      itemBuilder: (BuildContext context, int index) {
        Category category = widget.categories.elementAt(index);
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/Category', arguments: new RouteArgument(id: category.id, param: [category]));
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                alignment: AlignmentDirectional.topCenter,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).accentColor.withOpacity(0.2),
                        ])),
                child: Hero(
                  tag: category.id,
                  child: category.image.url.toLowerCase().endsWith('.svg')
                      ? Container(
                    height: 80,
                    width: 80,
                    child: SvgPicture.network(
                      category.image.url,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: category.image.thumb,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -50,
                bottom: -100,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                top: -60,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 90, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    /*Row(
                      children: <Widget>[
                        // The title of the product
                        Expanded(
                          child: Text(
                            _con.products.where((product) => product.category.id == category.id).length.toString() + ' Products',
                            style: Theme.of(context).textTheme.body1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        /*Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        Text(
                          category.name,
                          style: Theme.of(context).textTheme.body2,
                        )*/
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        );
      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
    );
  }
}
