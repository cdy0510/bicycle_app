package com.example.BicycleApp.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.view.KeyEvent;
import android.webkit.WebChromeClient;
import android.webkit.WebView;


public class MainActivity extends Activity {

	private WebView mWebView;

	WebChromeClient mChromeClient = new WebChromeClient();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		setLayout();

		String version2;

		try {
			PackageInfo i2 = getPackageManager().getPackageInfo(getPackageName(), 0);

			version2 = i2.versionName;

		} catch (NameNotFoundException e) {
			version2 = "";
		}

		SharedPreferences pref2 = getSharedPreferences("pref2",Activity.MODE_PRIVATE); // UI 상태를 저장합니다.
		SharedPreferences.Editor editor2 = pref2.edit(); // Editor를 불러옵니다
		editor2.putString("check_version", version2); // 저장할 값들을 입력합니다.
		editor2.commit(); // 저장합니다.
		
		String check_version2 = pref2.getString("check_version", "");
		String check_status2 = pref2.getString("check_status", "");
		
		if (!check_version2.equals(check_status2)) {
			AlertDialog alert2 = new AlertDialog.Builder(this)
					.setIcon(R.drawable.ic_launcher)
					.setTitle("튜토리얼")
					.setMessage(
							"Bicycle은 사용자의 자전거 운동능력 향상에 도움을 줄 수 있는 애플리케이션 입니다. "
									+ "\n\n자전거 주행이 시작되면 주행속도, 주행시간, 주행거리, 휴식시간, 위치정보 등의 애플리케이션 사용자의 편의를 고려한 다양한 서비스를 제공합니다. "
									+ "또한 자전거 주행 기록을 저장할 수 있어 사용자의 운동능력을 체계적으로 관리 할 수 있습니다."
									+ "\n\n지원 스마트폰은 480X320 ~ 1280X720 지원 해상도의 모든 안드로이드 폰(Android 2.2 이상) 입니다."
									+ "\n\nBicycle 을 통해 사용자들의 체계적인 운동능력 향상 및 환경보호에 도움이 되길 바랍니다.")
					.setPositiveButton("다시보지않기",new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog,int which) {
									String version2;

									try {
										PackageInfo i2 = getPackageManager().getPackageInfo(getPackageName(), 0);
										version2 = i2.versionName;
									} catch (NameNotFoundException e) {
										version2 = "";
									}

									SharedPreferences pref2 = getSharedPreferences("pref2", Activity.MODE_PRIVATE);

									// UI 상태를 저장합니다.
									SharedPreferences.Editor editor2 = pref2.edit(); // Editor를 불러옵니다
									editor2.putString("check_status", version2);
									editor2.commit(); // 저장합니다.
									dialog.cancel();
								}
							})
					.setNegativeButton("확인",new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog,
								int which) {
							dialog.dismiss();
						}
					}).show();
		}

		String version;

		try {

			PackageInfo i = getPackageManager().getPackageInfo(
					getPackageName(), 0);

			version = i.versionName;

		} catch (NameNotFoundException e) {

			version = "";

		}

		SharedPreferences pref = getSharedPreferences("pref",
				Activity.MODE_PRIVATE); // UI 상태를 저장합니다.

		SharedPreferences.Editor editor = pref.edit(); // Editor를 불러옵니다

		editor.putString("check_version", version); // 저장할 값들을 입력합니다.

		editor.commit(); // 저장합니다.

		String check_version = pref.getString("check_version", "");//

		String check_status = pref.getString("check_status", "");

		if (!check_version.equals(check_status)) {

			AlertDialog alert = new AlertDialog.Builder(this)
					.setIcon(R.drawable.ic_launcher)

					.setTitle("동의")

					.setMessage(
							"자전거 활동 결과(이동 궤적) 공유 및 위치 추적을 위한 위치기반서비스를 제공함에 있어 서비스 이용자에게 다음과 같은 내용을 고지하고 개인위치정보사용에 대한 사전 동의를 구합니다."
									+ "\n\n1.	귀하의 위치정보는 “주식회사 테크에이스솔루션”에게 제공됩니다. 위치정보는 엄격한 인증 절차를 걸친 최소한의 관리자만이 접근할 수 있도록 관리됩니다."
									+ "\n\n2.	제공된 위치정보는 다음 각 호의 목적으로 이용되며, 타 목적으로는 이용되지 않습니다."
									+ "\n-	이동 궤적의 표시"
									+ "\n-	사용자 위치 확인"
									+ "\n\n단, [위치정보의 보호 및 이용 등에 관한 법률] 제4장에 의해 재난 또는 재해의 위험 등으로부터의 긴급구조를 위한 목적 하에서는 개인위치정보 주체의 동의 없이도 긴급구조기관에 위치정보가 제공될 수 있습니다."
									+ "\n\n3.	귀하는 귀하의 개인 위치정보 제공 내역을 앱에서 확인할 수 있습니다."
									+ "\n제공자: 주식회사 테크에이스솔루션"
									+ "\n주 소 : 서울시 금천구 디지털로 130 남성프라자 910호"
									+ "\n전 화: 02-2104-0370"
									+ "\n홈페이지 : www.tecace.com")

					.setPositiveButton("다시보지않기",
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog,
										int which) {

									String version;

									try {

										PackageInfo i = getPackageManager()
												.getPackageInfo(
														getPackageName(), 0);

										version = i.versionName;

									} catch (NameNotFoundException e) {

										version = "";

									}

									SharedPreferences pref = getSharedPreferences(
											"pref", Activity.MODE_PRIVATE);

									// UI 상태를 저장합니다.

									SharedPreferences.Editor editor = pref
											.edit(); // Editor를 불러옵니다

									editor.putString("check_status", version);

									editor.commit(); // 저장합니다.

									dialog.cancel();

								}

							})

					.setNegativeButton("확인",
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog,
										int which) {

									dialog.dismiss();

								}

							}).show();

		}

		// 웹뷰에서 자바스크립트실행가능
		mWebView.getSettings().setJavaScriptEnabled(true);
		// 크기 조정
		mWebView.getSettings().setUseWideViewPort(true);
		mWebView.getSettings().setLoadWithOverviewMode(true);
		// 구글홈페이지 지정
		mWebView.loadUrl("http://192.168.1.2:8080/cycleApp/home.html");
		// WebViewClient 지정
		// mWebView.setWebViewClient(new WebViewClientClass());
		mWebView.setWebChromeClient(mChromeClient);

	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if ((keyCode == KeyEvent.KEYCODE_BACK) && mWebView.canGoBack()) {
			mWebView.goBack();
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}

	/*
	 * private class WebViewClientClass extends WebViewClient {
	 * 
	 * @Override public boolean shouldOverrideUrlLoading(WebView view, String
	 * url) { view.loadUrl(url); return true; }
	 * 
	 * }
	 */

	
	/*
	 * Layout
	 */
	private void setLayout() {
		mWebView = (WebView) findViewById(R.id.webview);
	}

}