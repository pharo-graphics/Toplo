Class {
	#name : #ToThemeApplicationCheckboxPanelModel,
	#superclass : #ToThemeApplicationLineAndStampsPanelModel,
	#category : #'Toplo-Theme-Examples'
}

{ #category : #'as yet unclassified' }
ToThemeApplicationCheckboxPanelModel >> allStampsVariation [

	^ { nil }
]

{ #category : #accessing }
ToThemeApplicationCheckboxPanelModel >> makeElements [

	| check1 check2 check3 radio1 radio2 radio3 group |
	check1 := (ToCheckbox id: #check1) labelText: 'apple'.
	check2 := (ToCheckbox id: #check2) labelText: 'banana'.
	check3 := (ToCheckbox id: #check3) labelText: 'cacao'.
	radio1 := (ToCheckbox id: #radio1) labelText: 'lama'.
	radio2 := (ToCheckbox id: #radio2) labelText: 'alpaga'.
	radio3 := (ToCheckbox id: #radio3) labelText: 'guanaco'.
	group := ToCheckableGroup new withStrictCheckingStrategy.
	radio1 addToGroup: group.
	radio2 addToGroup: group.
	radio3 addToGroup: group.
	radio1 check.
	radio1 addStamp: #radio.
	radio2 addStamp: #radio.
	radio3 addStamp: #radio.
	^ {
		  check1.
		  check2.
		  check3.
		  BlElement new visibility: BlVisibility hidden; size:80@1; yourself.
		  radio1.
		  radio2.
		  radio3 }
]

{ #category : #accessing }
ToThemeApplicationCheckboxPanelModel >> name [

	^ 'Checkbox and Radio'
]
