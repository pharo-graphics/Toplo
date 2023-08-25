Class {
	#name : #ToTripletSubmenuColumnStrategy,
	#superclass : #ToTripletColumnStrategy,
	#instVars : [
		'rightIcon',
		'fill'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #layout }
ToTripletSubmenuColumnStrategy >> childrenIn: aSubmenu [

	^ (super childrenIn: aSubmenu) , { 
		  self privateJustificationFill.
		  self rightIcon }
]

{ #category : #accessing }
ToTripletSubmenuColumnStrategy >> privateJustificationFill [

	^ fill ifNil: [ 
		  fill := ToElement new
			          id: self privateJustificationFillId;
			          matchParent ]
]

{ #category : #accessing }
ToTripletSubmenuColumnStrategy >> privateJustificationFillId [

	^ #'justification'
]

{ #category : #accessing }
ToTripletSubmenuColumnStrategy >> rightIcon [

	^ rightIcon ifNil: [ 
		  rightIcon := (ToImage inner: self rightIconImage)
			               hExact: 18;
			               constraintsDo: [ :c | 
				               c linear vertical alignCenter.
				               c linear horizontal alignCenter ];
			               in: [ :im | im layout alignCenterRight ];
			               yourself ]
]

{ #category : #accessing }
ToTripletSubmenuColumnStrategy >> rightIconImage [

	^ ToThemeIcons iconPlainTriangle5x9
]
