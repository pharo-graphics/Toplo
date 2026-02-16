"
```
| te skin | 
te := ToElement new.
skin := ToScriptableSkin new.
skin onInstallSkinEvent: [ :e | e size: 30 asPoint. e background: Color yellow ].
skin onHoveredSkinEvent: [ :e | e background: Color red ].
skin onLeavedSkinEvent: [ :e | e background: Color yellow ].
te defaultRawSkin: skin.
te openInSpace
```

instead of :
```
| te | 
te := ToElement new.
te 
	addEventHandlerOn: ToInstallSkinEvent 
	do: [ :event | event elementDo: [:e | e size: 30 asPoint. e background: Color yellow ] ].
te 
	addEventHandlerOn: ToHoveredSkinEvent 
	do: [ :event | event elementDo: [:e | e size: 30 asPoint. e background: Color red ] ].
te 
	addEventHandlerOn: ToLeavedSkinEvent 
	do: [ :event | event elementDo: [:e | e size: 30 asPoint. e background: Color yellow ] ].
te openInSpace
```




"
Class {
	#name : #ToScriptableSkin,
	#superclass : #ToSkin,
	#instVars : [
		'handlerMap'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - event managing' }
ToScriptableSkin >> handleEvent: anEvent [

	| handler |
	handler := handlerMap at: anEvent class ifAbsent: [ ^ self ].
	anEvent elementDo: [ :e | handler value: e value: anEvent ]
]

{ #category : #initialization }
ToScriptableSkin >> initialize [ 

	super initialize.
	handlerMap := IdentityDictionary new
]

{ #category : #'event handling' }
ToScriptableSkin >> onCheckedSkinEvent: aValuable [

	handlerMap at: ToCheckedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onClickedSkinEvent: aValuable [

	handlerMap at: ToClickedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onClosedSkinEvent: aValuable [

	handlerMap at: ToClosedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onDeselectedSkinEvent: aValuable [

	handlerMap at: ToDeselectedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onDisabledSkinEvent: aValuable [

	handlerMap at: ToDisabledSkinEvent put: aValuable

]

{ #category : #'event handling' }
ToScriptableSkin >> onDragStartedSkinEvent: aValuable [

	handlerMap at: ToDragStartedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onDraggedSkinEvent: aValuable [

	handlerMap at: ToDraggedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onDroppedSkinEvent: aValuable [

	handlerMap at: ToDroppedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onEnabledSkinEvent: aValuable [

	handlerMap at: ToEnabledSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onFocusedSkinEvent: aValuable [

	handlerMap at: ToFocusedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onHoveredSkinEvent: aValuable [

	handlerMap at: ToHoveredSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onIndeterminateSkinEvent: aValuable [

	handlerMap at: ToIndeterminateSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onInstallSkinEvent: aValuable [

	handlerMap at: ToInstallSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onLeftSkinEvent: aValuable [

	handlerMap at: ToLeftSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onPressedSkinEvent: aValuable [

	handlerMap at: ToPressedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onReleasedSkinEvent: aValuable [

	handlerMap at: ToReleasedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onSelectableSkinEvent: aValuable [

	handlerMap at: ToSelectableSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onSelectedSkinEvent: aValuable [

	handlerMap at: ToSelectedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onStillHoveredSkinEvent: aValuable [

	handlerMap at: ToStillHoveredSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onStillPressedSkinEvent: aValuable [

	handlerMap at: ToStillPressedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onUncheckedSkinEvent: aValuable [

	handlerMap at: ToUncheckedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onUnfocusedSkinEvent: aValuable [

	handlerMap at: ToUnfocusedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onUninstallSkinEvent: aValuable [

	handlerMap at: ToUnfocusedSkinEvent put: aValuable
]

{ #category : #'event handling' }
ToScriptableSkin >> onUnselectableSkinEvent: aValuable [

	handlerMap at: ToUnselectableSkinEvent put: aValuable
]
