Class {
	#name : #ToCheckableSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToCheckableSkin >> checkedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> iconSkin [

	self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> indeterminateImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> labelSkin [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement icon: (ToImage inner: (anElement isChecked
				  ifTrue: [ self checkedImageIn: anElement ]
				  ifFalse: [ self uncheckedImageIn: anElement ])).
	self addLook: (ToCheckLook new
			 checkedImage: (self checkedImageIn: anElement);
			 uncheckedImage: (self uncheckedImageIn: anElement);
			 indeterminateImage: (self indeterminateImageIn: anElement);
			 yourself)
]

{ #category : #accessing }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]
