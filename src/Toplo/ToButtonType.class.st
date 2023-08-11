Class {
	#name : #ToButtonType,
	#superclass : #Object,
	#instVars : [
		'danger'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToButtonType >> backgroundLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerBackgroundLookIn: anElement ]
		  ifFalse: [ self regularBackgroundLookIn: anElement ]
]

{ #category : #accessing }
ToButtonType >> borderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | Color transparent ];
		  width: [ :e | e toTheme lineWidth ];
		  yourself
]

{ #category : #accessing }
ToButtonType >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonType >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #accessing }
ToButtonType >> dangerBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> dangerFormLookIn: anElement [

	^ ToImageFormLook new
		disabledColor: [ :e | e toTheme colorImageDisabled ];
		initialColor: [ :e | e toTheme colorError];
		hoverColor: [ :e | e toTheme colorErrorHover];
		pressedColor: [ :e | e toTheme colorError darker];
		yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> dangerLabelLookIn: anElement [

	^ ToLabelTextLook new
		  disabledColor: [ :e | e toTheme colorTextDisabled ];
		  initialColor: [ :e | e toTheme colorError ];
		  hoverColor: [ :e | e toTheme colorErrorHover ];
		  pressedColor: [ :e | e toTheme colorError darker ];
		  yourself
]

{ #category : #accessing }
ToButtonType >> dashed: aBoolean [

	Error signal: 'Invalid property'.
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> iconLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerFormLookIn: anElement ]
		  ifFalse: [ self regularFormLookIn: anElement ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> labelLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerLabelLookIn: anElement ]
		  ifFalse: [ self regularLabelLookIn: anElement ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> onSkinInstalled: aSkin in: anElement [

	| borderLook backgroundLook |

"	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal)."

	" remove the background and the border in case the button type is changing "
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	backgroundLook := self backgroundLookIn: anElement.
	backgroundLook ifNotNil: [ aSkin addLook: backgroundLook ].
	borderLook := self borderLookIn: anElement.
	borderLook ifNil: [ ^ self ].
	aSkin addLook: borderLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> onSkinUninstalled: aSkin in: anElement [


]

{ #category : #accessing }
ToButtonType >> regularBackgroundLookIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularFormLookIn: anElement [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularLabelLookIn: anElement [

	self subclassResponsibility 
]
