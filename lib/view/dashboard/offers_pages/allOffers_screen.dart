import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/offer_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlloffersScreen extends StatefulWidget {
  const AlloffersScreen({super.key});

  @override
  State<AlloffersScreen> createState() => _AlloffersScreenState();
}

class _AlloffersScreenState extends State<AlloffersScreen> {
  bool isCopied = false; // To manage the "Copied" text visibility
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<OfferViewModel>(context, listen: false).getOfferList(
          context: context, date: DateFormat('dd-MM-yyyy').format(dateTime));
    });
  }

  // Function to copy the text to the clipboard
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      setState(() {
        isCopied = true;
      });
      // Optionally reset "Copied" text after a few seconds
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isCopied = false;
        });
      });
    });
  }

  int selectIndex = -1;
  String coupne = 'xzcxvcvbbvb';
  @override
  Widget build(BuildContext context) {
    return Consumer<OfferViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: const CustomAppBar(
            heading: 'Offers',
          ),
          body: PageLayout_Page(
            child: ListView.builder(
                itemCount: viewModel.offerListModel?.data?.length,
                itemBuilder: (context, index) {
                  var data = viewModel.offerListModel?.data?[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data?.offerName ?? '',
                          style: titleTextStyle,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            data?.imageUrl ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23qSvFQm2bH4nUAwxBk7ZzBQm5Qi__4imxg&s',
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          'Graw now: ${data?.discountPercentage}% OFF on ${data?.bookingType} ${data?.offerName}',
                          style: textTitleHeading,
                        ),
                        Text(
                          data?.description ?? '',
                          style: titleTextStyle1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data?.offerCode ?? '',
                                style: titleTextStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  copyToClipboard(data?.offerCode ?? '');
                                },
                                child: Row(
                                  children: [
                                    isCopied
                                        ? const Text(
                                            'Copied',
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        : Text('CopyCodes'),
                                    const SizedBox(width: 5),
                                    isCopied
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Icon(Icons.copy)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Valid till : ${data?.endDate}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            CustomButtonSmall(
                                height: 40,
                                width: 120,
                                loading:
                                    viewModel.isLoading && selectIndex == index,
                                btnHeading: 'View Details',
                                onTap: () {
                                  setState(() {
                                    selectIndex = index;
                                  });
                                  // context.push('/offerDetails');
                                  viewModel.getOfferDetails(
                                      context: context,
                                      offerId: data?.offerId ?? 0);
                                })
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
