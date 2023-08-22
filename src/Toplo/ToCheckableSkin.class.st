Class {
	#name : #ToCheckableSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> backgroundLookIn: anElement [

	^ self type checkableButtonBackgroundLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> borderLookIn: anElement [

	^ self type checkableButtonBorderLookIn: anElement
]

{ #category : #'accessing images' }
ToCheckableSkin >> checkedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'private - shaping/sizing' }
ToCheckableSkin >> defaultPaddingIn: anElement [ 

	^ (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal / 4
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal / 4)
]

{ #category : #'t - shapeable - initialization' }
ToCheckableSkin >> defaultShaping [

	^ ToRectangleShaping new
		  yourself
]

{ #category : #accessing }
ToCheckableSkin >> defaultType [

	^ ToButtonTextType new
]

{ #category : #'accessing images' }
ToCheckableSkin >> disabledImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> iconSkinIn: aButton [ 

	^ self subclassResponsibility 

]

{ #category : #'accessing images' }
ToCheckableSkin >> indeterminateImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> labelSkinIn: aButton [

	^ self type checkableLabelSkinIn: aButton

]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (ToCheckLook new
			 disabledImage: (self disabledImageIn: anElement);
			 checkedImage: (self checkedImageIn: anElement);
			 uncheckedImage: (self uncheckedImageIn: anElement);
			 indeterminateImage: (self indeterminateImageIn: anElement);
			 yourself)
]

{ #category : #'accessing images' }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]
