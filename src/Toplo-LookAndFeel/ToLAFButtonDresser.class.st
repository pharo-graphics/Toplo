Class {
	#name : #ToLAFButtonDresser,
	#superclass : #ToAbstractButtonDresser,
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #accessing }
ToLAFButtonDresser >> defaultSkin [

	^ ToAbstractTheme current class skinFor: ToButton type: ToAbstractSkin defaultType
]

{ #category : #'events handling' }
ToLAFButtonDresser >> escaped: anElement [

	

]

{ #category : #'events handling' }
ToLAFButtonDresser >> initialState: anElement [

	super initialState: anElement.

	anElement geometry: self skin builtGeometry.
	
	self skin defaultSize ifNotNil:[ :aPoint | 
		anElement constraintsDo:[ :c | 
			aPoint y > 0 ifTrue:[ c vertical exact: aPoint y ].
			aPoint x > 0 ifTrue:[ c horizontal exact: aPoint x ].
		].
	].
	
	self background: self skin background in: anElement.
	self border: self skin border in: anElement.
	
	anElement padding: self skin padding.
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leaved: anElement [

	

]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onInstalledIn: anElement [

	skin := anElement skin.
	self skin theme: anElement toTheme.
	
	self skin labelSkinType ifNotNil:[ :labelSkinType |
		anElement label ifNil:[ anElement label: ToLabel new ].
		anElement label skinType: labelSkinType.
	].
	
	super onInstalledIn: anElement.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	skin := nil
]

{ #category : #accessing }
ToLAFButtonDresser >> skin [

	^ skin ifNil: [ skin := self defaultSkin ]
]
