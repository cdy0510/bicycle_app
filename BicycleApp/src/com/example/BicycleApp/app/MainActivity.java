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

		SharedPreferences pref2 = getSharedPreferences("pref2",Activity.MODE_PRIVATE); // UI ���¸� �����մϴ�.
		SharedPreferences.Editor editor2 = pref2.edit(); // Editor�� �ҷ��ɴϴ�
		editor2.putString("check_version", version2); // ������ ������ �Է��մϴ�.
		editor2.commit(); // �����մϴ�.
		
		String check_version2 = pref2.getString("check_version", "");
		String check_status2 = pref2.getString("check_status", "");
		
		if (!check_version2.equals(check_status2)) {
			AlertDialog alert2 = new AlertDialog.Builder(this)
					.setIcon(R.drawable.ic_launcher)
					.setTitle("Ʃ�丮��")
					.setMessage(
							"Bicycle�� ������� ������ ��ɷ� ��� ������ �� �� �ִ� ���ø����̼� �Դϴ�. "
									+ "\n\n������ ������ ���۵Ǹ� ����ӵ�, ����ð�, ����Ÿ�, �޽Ľð�, ��ġ���� ���� ���ø����̼� ������� ���Ǹ� ����� �پ��� ���񽺸� �����մϴ�. "
									+ "���� ������ ���� ����� ������ �� �־� ������� ��ɷ��� ü�������� ���� �� �� �ֽ��ϴ�."
									+ "\n\n���� ����Ʈ���� 480X320 ~ 1280X720 ���� �ػ��� ��� �ȵ���̵� ��(Android 2.2 �̻�) �Դϴ�."
									+ "\n\nBicycle �� ���� ����ڵ��� ü������ ��ɷ� ��� �� ȯ�溸ȣ�� ������ �Ǳ� �ٶ��ϴ�.")
					.setPositiveButton("�ٽú����ʱ�",new DialogInterface.OnClickListener() {

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

									// UI ���¸� �����մϴ�.
									SharedPreferences.Editor editor2 = pref2.edit(); // Editor�� �ҷ��ɴϴ�
									editor2.putString("check_status", version2);
									editor2.commit(); // �����մϴ�.
									dialog.cancel();
								}
							})
					.setNegativeButton("Ȯ��",new DialogInterface.OnClickListener() {
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
				Activity.MODE_PRIVATE); // UI ���¸� �����մϴ�.

		SharedPreferences.Editor editor = pref.edit(); // Editor�� �ҷ��ɴϴ�

		editor.putString("check_version", version); // ������ ������ �Է��մϴ�.

		editor.commit(); // �����մϴ�.

		String check_version = pref.getString("check_version", "");//

		String check_status = pref.getString("check_status", "");

		if (!check_version.equals(check_status)) {

			AlertDialog alert = new AlertDialog.Builder(this)
					.setIcon(R.drawable.ic_launcher)

					.setTitle("����")

					.setMessage(
							"������ Ȱ�� ���(�̵� ����) ���� �� ��ġ ������ ���� ��ġ��ݼ��񽺸� �����Կ� �־� ���� �̿��ڿ��� ������ ���� ������ �����ϰ� ������ġ������뿡 ���� ���� ���Ǹ� ���մϴ�."
									+ "\n\n1.	������ ��ġ������ ���ֽ�ȸ�� ��ũ���̽��ַ�ǡ����� �����˴ϴ�. ��ġ������ ������ ���� ������ ��ģ �ּ����� �����ڸ��� ������ �� �ֵ��� �����˴ϴ�."
									+ "\n\n2.	������ ��ġ������ ���� �� ȣ�� �������� �̿�Ǹ�, Ÿ �������δ� �̿���� �ʽ��ϴ�."
									+ "\n-	�̵� ������ ǥ��"
									+ "\n-	����� ��ġ Ȯ��"
									+ "\n\n��, [��ġ������ ��ȣ �� �̿� � ���� ����] ��4�忡 ���� �糭 �Ǵ� ������ ���� �����κ����� ��ޱ����� ���� ���� �Ͽ����� ������ġ���� ��ü�� ���� ���̵� ��ޱ�������� ��ġ������ ������ �� �ֽ��ϴ�."
									+ "\n\n3.	���ϴ� ������ ���� ��ġ���� ���� ������ �ۿ��� Ȯ���� �� �ֽ��ϴ�."
									+ "\n������: �ֽ�ȸ�� ��ũ���̽��ַ��"
									+ "\n�� �� : ����� ��õ�� �����з� 130 ���������� 910ȣ"
									+ "\n�� ȭ: 02-2104-0370"
									+ "\nȨ������ : www.tecace.com")

					.setPositiveButton("�ٽú����ʱ�",
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

									// UI ���¸� �����մϴ�.

									SharedPreferences.Editor editor = pref
											.edit(); // Editor�� �ҷ��ɴϴ�

									editor.putString("check_status", version);

									editor.commit(); // �����մϴ�.

									dialog.cancel();

								}

							})

					.setNegativeButton("Ȯ��",
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog,
										int which) {

									dialog.dismiss();

								}

							}).show();

		}

		// ���信�� �ڹٽ�ũ��Ʈ���డ��
		mWebView.getSettings().setJavaScriptEnabled(true);
		// ũ�� ����
		mWebView.getSettings().setUseWideViewPort(true);
		mWebView.getSettings().setLoadWithOverviewMode(true);
		// ����Ȩ������ ����
		mWebView.loadUrl("http://192.168.1.2:8080/cycleApp/home.html");
		// WebViewClient ����
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