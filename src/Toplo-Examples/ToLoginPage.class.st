Class {
	#name : #ToLoginPage,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToLoginPage class >> open [

	<script>
	self new open
]

{ #category : #'instance creation' }
ToLoginPage >> open [

	| panel loginNamePanel passwdPanel btnLogin loginLabel loginValue pwLabel pwValue groupLogin btnPanel space sep btnCancel |
	panel := ToPane new.
	panel layout: BlFrameLayout new.
	panel matchParent.

	groupLogin := ToPane new beVertical.
	groupLogin width: 400.
	groupLogin vFitContent.
	groupLogin constraintsDo: [ :c | c frame vertical alignCenter ].
	groupLogin padding: (BlInsets all: 10).
	groupLogin border: (BlBorder paint: Color veryLightGray).
	groupLogin geometry: (BlRoundedRectangleGeometry cornerRadius: 12).

	loginNamePanel := ToPane new
		                  beHorizontal;
		                  hMatchParent;
		                  vFitContent.
	loginLabel := ToLabel new text: 'Login :'.

	loginLabel layout alignCenterRight.
	loginValue := ToTextField new hMatchParent.

	loginNamePanel addChildren: {
			loginLabel.
			loginValue }.
	passwdPanel := ToPane new
		               beHorizontal;
		               hMatchParent;
		               vFitContent.
	pwLabel := ToLabel new text: 'Password :'.
	pwLabel layout alignCenterRight.
	pwValue := ToTextField new hMatchParent.

	passwdPanel addChildren: {
			pwLabel.
			pwValue }.

	" get actual pwLabel and loginLabel width then reset pwLabel and loginLabel to the max "
	passwdPanel whenLayoutedDoOnce: [
		| w |
		w := pwLabel width max: loginLabel width.
		pwLabel width: w.
		loginLabel width: w ].

	btnPanel := ToPane new
		            beHorizontal;
		            hMatchParent;
		            vFitContent.
	btnLogin := ToButton new labelText: 'Accept'; yourself.
	btnLogin addStyleClass: #primary.
	btnLogin padding: (BlInsets
			 top: 10
			 left: 40
			 bottom: 10
			 right: 40).
	btnLogin margin: (BlInsets
			 top: 10
			 left: 0
			 bottom: 0
			 right: 0).
	btnLogin constraintsDo: [ :c | c linear horizontal alignCenter ].
	btnPanel addChild: btnLogin.
	sep := BlElement new constraintsDo: [ :c | c horizontal matchParent ].
	btnPanel addChild: sep.

	btnCancel := ToButton new labelText: 'Cancel'.
	btnCancel padding: (BlInsets
			 top: 10
			 left: 40
			 bottom: 10
			 right: 40).
	btnCancel margin: (BlInsets
			 top: 10
			 left: 0
			 bottom: 0
			 right: 0).
	btnCancel constraintsDo: [ :c | c linear horizontal alignCenter ].
	btnPanel addChild: btnCancel.

	"add elements to panel"

	groupLogin addChildren: {
			loginNamePanel.
			passwdPanel.
			btnPanel }.

	groupLogin constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	panel addChild: groupLogin.
	panel matchParent.
	space := panel openInSpace.
	space extent: 450 @ 200.
	space borderless: true.
	space resizable: false.
	space addEventHandlerOn: BlSpaceShownEvent do: [ space center ].

	btnCancel whenClickedDo: [ space close ]
]

{ #category : #'see class side' }
ToLoginPage >> seeClassSide [
]
