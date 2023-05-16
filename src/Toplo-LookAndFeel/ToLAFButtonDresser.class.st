Class {
	#name : #ToLAFButtonDresser,
	#superclass : #ToAbstractButtonDresser,
	#traits : 'TToSkinnableElementDresser',
	#classTraits : 'TToSkinnableElementDresser classTrait',
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFButtonDresser >> defaultToElementClass [

	^ ToButton
]

{ #category : #'events handling' }
ToLAFButtonDresser >> escaped: anElement [

	

]

{ #category : #'events handling' }
ToLAFButtonDresser >> hover: anElement event: anEvent [

	super hover: anElement event: anEvent.
	
	self background: self skin backgroundHover in: anElement.
	self border: self skin borderHover in: anElement.
]

{ #category : #'events handling' }
ToLAFButtonDresser >> initialState: anElement [

	super initialState: anElement.

	self background: self skin background in: anElement.
	self border: self skin border in: anElement.
]

{ #category : #accessing }
ToLAFButtonDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	self flag:'Labordep this is dirty, need to find a better solution'.
	^ aSkin isKindOf: ToAbstractButtonSkin
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leaved: anElement [

	self initialState: anElement.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onInstalledIn: anElement [

	skin := anElement skin.
	self skin theme: anElement toTheme.
	self haveCompatibleSkin ifFalse:[^ self].	
		
	self skin labelSkinType ifNotNil:[ :labelSkinType |
		anElement label ifNil:[ anElement label: ToLabel new ].
		anElement label skinType: labelSkinType.
	].
	
	super onInstalledIn: anElement.

	anElement geometry: self skin builtGeometry.
	
	self skin defaultSize ifNotNil:[ :aPoint | 
		anElement constraintsDo:[ :c | 
			aPoint y > 0 ifTrue:[ c vertical exact: aPoint y ].
			aPoint x > 0 ifTrue:[ c horizontal exact: aPoint x ].
		].
	].

	anElement padding: self skin padding.
	anElement effect: self skin shadow.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	skin := nil
]
