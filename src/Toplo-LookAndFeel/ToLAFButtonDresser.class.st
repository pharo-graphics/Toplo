Class {
	#name : #ToLAFButtonDresser,
	#superclass : #ToGeneralButtonDresser,
	#traits : 'TToSkinnableElementDresser',
	#classTraits : 'TToSkinnableElementDresser classTrait',
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFButtonDresser >> defaultToElementClass [

	^ ToButton
]

{ #category : #'events handling' }
ToLAFButtonDresser >> hover: anElement event: anEvent [

	| label image|
	super hover: anElement event: anEvent.
	
	"update main element"
	self background: self skin backgroundHover in: anElement.
	self border: self skin borderHover in: anElement.

	"label event dispatch"
	label := anElement label.
	(label notNil and:[label dresser notNil]) ifTrue:[ label dresser hover: label event: anEvent ].
	
	"icon event dispatch"
	image := anElement icon.
	(image notNil and:[image dresser notNil]) ifTrue:[ image dresser hover: image event: anEvent ].
]

{ #category : #'events handling' }
ToLAFButtonDresser >> initialState: anElement [

	| label image|
	super initialState: anElement.

	"update main element"
	self background: self skin background in: anElement.
	self border: self skin border in: anElement.
	
	"label event dispatch"
	label := anElement label.
	(label notNil and:[label dresser notNil]) ifTrue:[ label dresser initialState: label ].
	
	"icon event dispatch"
	image := anElement icon.
	(image notNil and:[image dresser notNil]) ifTrue:[ image dresser initialState: image ].
]

{ #category : #accessing }
ToLAFButtonDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	self flag:'Labordep this is dirty, need to find a better solution'.
	^ aSkin isKindOf: ToAbstractButtonSkin
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leaved: anElement event: anEvent [

	self initialState: anElement.
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leftClicked: anElement event: anEvent [

	super leftClicked: anElement event: anEvent.
	"self restoreUnpressedState."
	
	self hover: anElement event: anEvent
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leftPressed: anElement event: anEvent [
	| label image |

	"self savePressedState"
	
	"update main element"
	self background: self skin backgroundPressed in: anElement.
	self border: self skin borderPressed in: anElement.

	"label event dispatch"
	label := anElement label.
	(label notNil and:[label dresser notNil]) ifTrue:[ label dresser leftPressed: label event: anEvent ].
	
	"icon event dispatch"
	image := anElement icon.
	(image notNil and:[image dresser notNil]) ifTrue:[ image dresser leftPressed: image event: anEvent ].
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leftUp: anElement event: anEvent [

	self hover: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onInstalledIn: anElement [

	skin := anElement skin.
	self skin theme: anElement toTheme.
	self haveCompatibleSkin ifFalse:[^ self].	
		
	"Install target label skin type"
	self skin labelSkinType ifNotNil:[ :labelSkinType |
		anElement label ifNil:[ anElement label: ToLabel new ].
		anElement label skinType: labelSkinType.
	].
	
	"Install target icon skin type"
	self skin imageSkinType ifNotNil:[ :imageSkinType |
		anElement icon ifNil:[ anElement icon: ToImage new ].
		anElement icon skinType: imageSkinType.
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
	
	self skin onInstalledIn: anElement.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onUninstalledIn: anElement [

	self skin onUninstalledIn: anElement.
	super onUninstalledIn: anElement.
	skin := nil.
]
