Class {
	#name : #ToCheckableSkin,
	#superclass : #ToClickableSkin,
	#category : #'Toplo-Widget-Button-Skin'
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

	| switch disabledImage checkedImage uncheckedImage indeterminateImage |

	disabledImage := anElement disabledImage.
	checkedImage := anElement checkedImage.
	uncheckedImage := anElement uncheckedImage.
	indeterminateImage := anElement indeterminateImage.
	
	switch := [ :e |
	          e isDisabled
		          ifTrue: [  e disabledImage   ]
		          ifFalse: [
			          e isChecked
				          ifTrue: [  e checkedImage  ]
				          ifFalse: [
					          e isUnchecked
						          ifTrue: [ e uncheckedImage   ]
						          ifFalse: [  e indeterminateImage   ] ] ] ].

	super onSkinInstalledIn: anElement.
	self addLookUpdater: (ToLookDep new
			 applyWith: [ :e :v |
				 v removeFromParent.
				 e iconImage: v ];
			 whenInitialized: switch;
			 whenDisabled: switch;
			 whenClicked: switch;
			 yourself)
]

{ #category : #'accessing images' }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]
