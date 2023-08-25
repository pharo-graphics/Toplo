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

{ #category : #deprecated }
ToLAFButtonDresser >> hover: anElement event: anEvent [

	| label image |
	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith: '`@receiver hover: `@anElement event: `@anEvent'
			-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.

	super mouseEnterEvent: anEvent in: anElement.

	"update main element"
	anElement background: self skin backgroundHover.
	anElement border: self skin borderHover.

	"label event dispatch"
	label := anElement label.
	(label notNil and: [ label dresser notNil ]) ifTrue: [
		label dresser hover: label event: anEvent ].

	"icon event dispatch"
	image := anElement icon.
	(image notNil and: [ image dresser notNil ]) ifTrue: [
		image dresser hover: image event: anEvent ]
]

{ #category : #'events handling' }
ToLAFButtonDresser >> initialState: anElement [

	| label image |
	super initialState: anElement.

	"update main element"
	anElement background: self skin background.
	anElement border: self skin border.

	"label event dispatch"
	label := anElement label.
	(label notNil and: [ label dresser notNil ]) ifTrue: [
		label dresser initialState: label ].

	"icon event dispatch"
	image := anElement icon.
	(image notNil and: [ image dresser notNil ]) ifTrue: [
		image dresser initialState: image ]
]

{ #category : #accessing }
ToLAFButtonDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	self flag:'Labordep this is dirty, need to find a better solution'.
	^ aSkin isKindOf: ToAbstractButtonSkinDep
]

{ #category : #deprecated }
ToLAFButtonDresser >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.	self initialState: anElement.
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leftClickEvent: anEvent in: anElement [

	super leftClickEvent: anEvent in: anElement.
	"self restoreUnpressedState."

	self mouseEnterEvent: anEvent in: anElement
]

{ #category : #deprecated }
ToLAFButtonDresser >> leftClicked: anElement event: anEvent [

	self
		deprecated: 'Please use leftClickEvent:in: instead.'
		transformWith:
			'`@receiver leftClicked: `@anElement event: `@anEvent'
				-> '`@receiver leftClickEvent: `@anEvent in: `@anElement'.
	super leftClicked: anElement event: anEvent.
	"self restoreUnpressedState."
	
	self hover: anElement event: anEvent
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leftMouseDownEvent: anEvent in: anElement [

	| label image |
	"self savePressedState""update main element"
	anElement background: self skin backgroundPressed.
	anElement border: self skin borderPressed.

	"label event dispatch"
	label := anElement label.
	(label notNil and: [ label dresser notNil ]) ifTrue: [
		label dresser leftMouseDownEvent: anEvent in: label ].

	"icon event dispatch"
	image := anElement icon.
	(image notNil and: [ image dresser notNil ]) ifTrue: [
		image dresser leftMouseDownEvent: anEvent in: image ]
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leftMouseUpEvent: anEvent in: anElement [

	self mouseEnterEvent: anEvent in: anElement
]

{ #category : #deprecated }
ToLAFButtonDresser >> leftPressed: anElement event: anEvent [
	| label image |

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.

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

{ #category : #deprecated }
ToLAFButtonDresser >> leftUp: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver leftUp: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseUpEvent: `@anEvent in: `@anElement'.
	self hover: anElement event: anEvent
]

{ #category : #'events handling' }
ToLAFButtonDresser >> mouseEnterEvent: anEvent in: anElement [

	| label image |
	super mouseEnterEvent: anEvent in: anElement.

	"update main element"
	anElement background: self skin backgroundHover.
	anElement border: self skin borderHover.

	"label event dispatch"
	label := anElement label.
	(label notNil and: [ label dresser notNil ]) ifTrue: [
		label dresser hover: label event: anEvent ].

	"icon event dispatch"
	image := anElement icon.
	(image notNil and: [ image dresser notNil ]) ifTrue: [
		image dresser hover: image event: anEvent ]
]

{ #category : #'events handling' }
ToLAFButtonDresser >> mouseLeaveEvent: anEvent in: anElement [

	self initialState: anElement.
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
