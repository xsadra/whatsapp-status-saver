import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart'
    show kDefaultPadding, kHeaderHeight;
import '../../../data/models/models.dart';
import '../../bloc/medias/bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/header.jpg',
            // height: 185,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kDefaultPadding),
                bottomRight: Radius.circular(kDefaultPadding),
              ),
            ),
            height: kHeaderHeight,
            //color: Colors.black12,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      "Good Morning!",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Spacer(),
                    Text(
                      "Status Saver",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black54),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                BlocBuilder<MediasBloc, MediasState>(
                  buildWhen: (previous, current) =>
                      previous != current && current.state is Loaded,
                  builder: (context, state) {
                    if (state is Loaded) {
                      var toShow = state.accountToShow;

                      return Row(
                        children: [
                          for (AccountType account in state.accounts)
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                // color: const Color(0xFF4C0050),
                                border: account.isOf(toShow)
                                    ? Border(
                                        bottom: BorderSide(
                                            width: 4, color: Colors.black26))
                                    : null,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: InkWell(
                                  onTap: () => context
                                      .read<MediasBloc>()
                                      .add(GetAccountMedias(
                                        setAccountToShow: account,
                                      )),
                                  child: Image.asset(
                                    account.isOf(toShow)
                                        ? account.imagePath
                                        : account.saturatedImagePath,
                                    width: account.isOf(toShow) ? 36 : 40,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
