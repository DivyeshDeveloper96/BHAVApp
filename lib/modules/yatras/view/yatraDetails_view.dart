import 'dart:convert';

import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:bhavapp/modules/login/view/login_view.dart';
import 'package:bhavapp/modules/yatras/controllers/yatraDeatils_controller.dart';
import 'package:bhavapp/routes/page_identifier.dart';
import 'package:bhavapp/widgets/AppBottomSheet.dart';
import 'package:bhavapp/widgets/customImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../shared/AppConstants.dart';
import '../../../utils/utilsCommon.dart';
import '../../../widgets/child_scaffold.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class YatraDetailsView extends StatefulWidget {
  const YatraDetailsView({super.key});

  @override
  State<YatraDetailsView> createState() => _YatraDetailsViewState();
}

class _YatraDetailsViewState extends State<YatraDetailsView> {
  final YatraDetailsController yatraDetailsController = Get.put(
    YatraDetailsController(),
  );

  @override
  void initState() {
    var args = Get.arguments;
    yatraDetailsController.yatraId.value = args.toString();
    yatraDetailsController.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const htmlData = r"""
    <h3>🗓️ Yatra Dates</h3>
<table class="table-simple">
    <tr>
        <td><strong>Arrival at Sri Pandharpur Dham</strong></td>
        <td>16th Jan 2026 (Friday) Morning 10am</td>
    </tr>
    <tr>
        <td><strong>Departure from Sri Pandharpur Dham</strong></td>
        <td>18th Jan 2026 (Sunday) 2pm</td>
    </tr>
</table>

<p style="color:red">NOTE: We have stopped room and bus bookings (deadline was 10 Nov 2025). You can
    still register and receive prasad for 3 days, but you must arrange your own accommodation and
    travel.</p>

<!--
<h3>🕉️ Brahmacharis</h3>
<p>Brahmacharis can attend the Yatra for Free - we will get Sponsorship from Congregation. When Registering please check the "Are you a Brahmachari?" flag</p>
-->

<h3>💰 Yatra Charges</h3>
<p><strong>Registration Charges:</strong> ₹2,100 per person</p>

<h4>✅ What’s Included?</h4>
<ul>
    <li>Registration and internal travel to Sri Vitthal–Rukmini Temple only</li>
    <li>Three daily meals — Breakfast, Lunch & Dinner</li>
</ul>

<h4>🚫 What’s Not Included?</h4>
<ul>
    <li>Accommodation in Pandharpur</li>
    <li>Transit Accommodation in Pune (if you are coming from out of Pune)</li>
    <li>Travel between Pune and Pandharpur</li>
</ul>

<p><strong>GST 5% will be additional on the Total amount</strong></p>

<h3>👶 Children Policy</h3>
<h4>Children below 5 years (as of 1 Jan 2026)</h4>
<ul>
    <li>💯 <strong>100% waiver</strong> on registration charges</li>
    <li>📝 No need to be registered</li>
    <li>❌ No separate seat in buses (internal or Pune–Pandharpur)</li>
</ul>

<h4>Children between 5 and 10 years (as of 1 Jan 2026)</h4>
<ul>
    <li>🎁 <strong>50% waiver</strong> on registration charges</li>
    <li>📝 Must be registered</li>
    <li>❌ No separate seat in buses (internal or Pune–Pandharpur)</li>
    <li>✅ Full transportation charge applies if a seat is required</li>
</ul>
<p class="muted-small">
    🛏️ <strong>Room Allocation:</strong>These children are counted when calculating room capacity.
    They must be assigned a bed/mattress and cannot be marked as “no bed required.”
</p>
<h3>🛕 How to Reach Pandharpur</h3>

<h4>🚗 By Road</h4>
<p>
    Pandharpur is well connected with major cities in Maharashtra by road, and
    state transport corporation buses are regularly available. Pune is at a distance
    of around <strong>204 km</strong> while Mumbai is around <strong>386 km</strong> away.
    Bijapur (<strong>100 km</strong>) and Solapur (<strong>74 km</strong>) are close to
    Pandharpur, and direct transport from these cities is also available.
</p>

<h5>From Mumbai</h5>
<p>
    To travel from Mumbai to Pandharpur, head towards Panvel and take the
    <strong>Mumbai–Pune Expressway</strong> to reach Pune. From Pune city, proceed via
    <em>Magarpatta City – Loni Kalbhor – Kedagaon – Kurkumbh – Khadki</em>.
    Continue on the <strong>Mumbai–Solapur Highway</strong> and head towards
    <em>Indapur – Tembhumi – Karkamb</em> to reach Pandharpur.
</p>

<h5>From Pune</h5>
<p>
    You can follow the same route as above, or alternatively take the scenic route
    via <em>Shirwal</em>. From Pune city, head towards
    <em>Katraj – Shirwal – Lonand – Phaltan – Malshiras – Pandharpur</em>.
</p>

<h4>🚆 By Train</h4>
<p>
    <strong>Kurdwadi</strong>, at a distance of <strong>50 km</strong> from Pandharpur,
    is the nearest railway station and connects Pandharpur with the rest of the country.
    From Kurdwadi, Pandharpur can be easily reached both by road and train.
</p>
<p>
    <strong>Solapur</strong>, at a distance of <strong>74 km</strong>, is the nearest major
    railhead.
    Trains from cities like <em>Bangalore, Chennai, Mumbai, Delhi, Hyderabad,</em> and
    <em>Pune</em> are regularly available. From both Solapur and Kurdwadi, state transport
    buses and private taxis are easily accessible.
</p>
<p>
    Travel times: approximately <strong>4 hours</strong> from Pune,
    <strong>9 hours</strong> from Mumbai, <strong>12 hours</strong> from Bangalore,
    and <strong>14 hours</strong> from Chennai or Delhi.
</p>

<h4>✈️ By Air</h4>
<p>
    <strong>Pune</strong>, at a distance of <strong>204 km</strong>, is the nearest domestic
    airport.
    Pune is well connected by air with most major cities in India. Taxi cabs and
    state transport buses from Pune airport to Pandharpur are readily available.
</p>
<p>
    Alternatively, tourists can travel from Pune by train via <strong>Solapur</strong> or
    <strong>Kurdwadi</strong> — from where Pandharpur is about <strong>74 km</strong> and
    <strong>50 km</strong> away respectively.
</p>
    """;
    final Map<String, Style> htmlStyles = {
      "h1": Style(
        fontSize: FontSize(18),
        fontWeight: FontWeight.bold,
        margin: Margins.zero,
      ),

      "h3": Style(
        fontSize: FontSize(18),
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
        margin: Margins.only(bottom: 8),
      ),

      "h4": Style(
        fontSize: FontSize(16),
        fontWeight: FontWeight.w600,
        margin: Margins.only(top: 12, bottom: 6),
      ),

      "h5": Style(fontSize: FontSize(14), fontWeight: FontWeight.w600),

      "p": Style(
        fontSize: FontSize(14),
        lineHeight: LineHeight(1.5),
        margin: Margins.only(bottom: 10),
      ),

      "ul": Style(
        padding: HtmlPaddings.only(left: 18),
        margin: Margins.only(bottom: 10),
      ),

      "li": Style(fontSize: FontSize(14), margin: Margins.only(bottom: 6)),

      "table": Style(
        border: Border.all(color: Colors.grey.shade300),
        margin: Margins.only(bottom: 12),
      ),

      "td": Style(
        padding: HtmlPaddings.all(8),
        border: Border.all(color: Colors.grey.shade200),
        fontSize: FontSize(14),
      ),

      "fieldset": Style(
        border: Border.all(color: Colors.grey.shade300),
        /* borderRadius: BorderRadius.circular(14),*/
        padding: HtmlPaddings.all(14),
        margin: Margins.only(top: 16, bottom: 16),
        backgroundColor: Colors.white,
      ),

      "legend": Style(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple.shade900,
        padding: HtmlPaddings.symmetric(horizontal: 6),
      ),
    };

    return AppScaffoldChild(
      title: "Yatra Details",
      body: Obx(
        () =>
            yatraDetailsController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri('https://yatra.vaisnavaswami.com/'),
                      ),
                      onLoadStart: (controller, url) {
                        debugPrint('Started loading: $url');
                      },
                      onLoadStop: (controller, url) {
                        debugPrint('Finished loading: $url');
                      },
                    ),
                    // Sticky Bottom Container
                    /* Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, -2),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: CustomButton(
                            buttonType: ButtonType.filled,
                            onTap: () {
                              if (IS_LOGGEDIN) {
                                Get.toNamed(PageIdentifier.myRegistraions.name);
                              } else {
                                showLoginBottomSheet(context);
                              }
                            },
                            title: 'Click to Register',
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
      ),
      actions: [],
    );
  }

  Widget YatraHeader() {
    return Stack(
      children: [
        CustomImageLoader(
          height: 200,
          fit: BoxFit.cover,
          imageUrl:
              yatraDetailsController.yatraDetailsResp.value?.imageUrl ?? "",
        ),
        Positioned.fill(child: Container(color: Colors.black45)),
        Positioned(
          bottom: 8,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                yatraDetailsController.yatraDetailsResp.value?.name ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "("
                "${UtilsCommon.formatDateAs(yatraDetailsController.yatraDetailsResp.value?.yatraStartAt ?? "", "dd MMM yy")} to ${UtilsCommon.formatDateAs(yatraDetailsController.yatraDetailsResp.value?.yatraEndAt ?? "", "dd MMM yy")}"
                ")",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showLoginBottomSheet(BuildContext context) {
    AppBottomSheet.show(context, title: "Login", child: LoginView());
  }

  yatraContent(String htmlData, Map<String, Style> htmlStyles) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FutureBuilder<String>(
          future: yatraDetailsController.loadHtml(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load content',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              );
            }
            final loadedHtml = snapshot.data;
            if (loadedHtml == null || loadedHtml.trim().isEmpty) {
              return const Text(
                'No details available',
                style: TextStyle(color: Colors.grey),
              );
            }
            return Html(data: loadedHtml, style: htmlStyles);
          },
        ),
      ),
    );
  }
}

class _YatraOverview extends StatelessWidget {
  const _YatraOverview();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "A journey of spirit and discovery through the majestic Himalayas.",
        style: TextStyle(fontSize: 15, color: Colors.grey),
      ),
    );
  }
}

class _YatraHighlights extends StatelessWidget {
  const _YatraHighlights();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _Highlight(icon: Icons.calendar_today, label: "7 Days"),
        _Highlight(icon: Icons.trending_up, label: "Moderate"),
        _Highlight(icon: Icons.landscape, label: "Himalayas"),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Highlight({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: ColorConstant.kPrimary.withOpacity(.15),
          child: Icon(icon, color: ColorConstant.kPrimary),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _YatraInfoList extends StatelessWidget {
  const _YatraInfoList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _InfoTile(
          icon: Icons.luggage,
          title: "What to Pack",
          subtitle: "Warm clothes, sturdy boots",
        ),
        _InfoTile(
          icon: Icons.cloud,
          title: "Best Time",
          subtitle: "April to June",
        ),
        _InfoTile(
          icon: Icons.check_circle,
          title: "Inclusions",
          subtitle: "Meals, stay, guide",
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorConstant.kPrimary.withOpacity(.15),
        child: Icon(icon, color: ColorConstant.kPrimary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
