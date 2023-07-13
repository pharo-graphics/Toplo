Class {
	#name : #ToButtonSkin,
	#superclass : #ToWidgetSkin,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'iconChangeHandler',
		'labelChangeHandler',
		'danger'
	],
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #accessing }
ToButtonSkin >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonSkin >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	iconChangeHandler := BlEventHandler
		                     on: ToButtonIconChanged
		                     do: [ :evt | self onInstalledIconIn: anElement. ].
	labelChangeHandler := BlEventHandler
		                      on: ToButtonLabelChanged
		                      do: [ :evt | self onInstalledLabelIn: anElement ].
	anElement addEventHandler: iconChangeHandler.
	anElement addEventHandler: labelChangeHandler.


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onInstalledIconIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onInstalledLabelIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onUninstalledIconIn: anElement [

	anElement icon ifNil: [ ^ self ].
	anElement icon withoutSkin
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onUninstalledLabelIn: anElement [

	anElement label ifNil: [ ^ self ].
	anElement label withoutSkin
]

{ #category : #accessing }
ToButtonSkin >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := BlTextAttributesBuilder new.
	builder lineSpacing: anElement toTheme lineHeight.
	builder weight: anElement toTheme fontWeightStrong.
	builder defaultFontSize: anElement toTheme fontSize.
	builder defaultFontName: anElement toTheme fontFamilyCode.
	builder foreground: anElement toTheme colorText.

	^ builder 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: iconChangeHandler.
	anElement removeEventHandler: labelChangeHandler.
	super uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.

	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: anElement toTheme borderRadius).

	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).

	self onInstalledLabelIn: anElement.
	self onInstalledIconIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> whenRemovedFromSpace: anEvent in: anElement [

	super whenRemovedFromSpace: anEvent in: anElement.
	self onUninstalledLabelIn: anElement.
	self onUninstalledIconIn: anElement
]
