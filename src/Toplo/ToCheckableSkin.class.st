Class {
	#name : #ToCheckableSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToCheckableSkin >> checkedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - accessing' }
ToCheckableSkin >> childSkinsToHandle [

	^ {
		  (ToChildSkin new
			   slotName: #icon;
			   skinBuilder: [ :e | self iconSkinIn: e ];
			   yourself).
		  (ToChildSkin new
			   slotName: #label;
			   skinBuilder: [ :e | self labelSkinIn: e ];
			   yourself) }
]

{ #category : #accessing }
ToCheckableSkin >> disabledImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> iconSkinIn: aButton [

	self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> indeterminateImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> labelSkinIn: aButton [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement icon: (ToImage inner: (anElement isChecked
				  ifTrue: [ self checkedImageIn: anElement ]
				  ifFalse: [ self uncheckedImageIn: anElement ])).
	anElement checkOrientableLayout.

	self addLook: (ToCheckLook new
			disabledImage: (self disabledImageIn: anElement);
			 checkedImage: (self checkedImageIn: anElement);
			 uncheckedImage: (self uncheckedImageIn: anElement);
			 indeterminateImage: (self indeterminateImageIn: anElement);
			 yourself)
]

{ #category : #accessing }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]
