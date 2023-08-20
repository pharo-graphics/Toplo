Class {
	#name : #ToCheckableSkin,
	#superclass : #ToAbstractButtonSkinNew,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> backgroundLookIn: anElement [

	^ nil
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> borderLookIn: anElement [

	^ nil
]

{ #category : #accessing }
ToCheckableSkin >> checkedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> disabledImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> indeterminateImageIn: anElement [

	^ self subclassResponsibility 
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

{ #category : #accessing }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]
