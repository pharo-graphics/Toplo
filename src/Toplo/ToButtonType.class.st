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

	^ anElement isDisabled
		  ifTrue: [ self disabledBackgroundLookIn: anElement ]
		  ifFalse: [
			  self danger
				  ifTrue: [ self enabledDangerBackgroundLookIn: anElement ]
				  ifFalse: [ self enabledRegularBackgroundLookIn: anElement ] ]
]

{ #category : #accessing }
ToButtonType >> borderLookIn: anElement [

	^ anElement isDisabled
		  ifTrue: [ self disabledBorderLookIn: anElement ]
		  ifFalse: [ nil ]
]

{ #category : #accessing }
ToButtonType >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonType >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> dangerFormLookIn: anElement [

	| formLook |
	formLook := ToImageFormLook new.
	formLook
		initialColor: [ :e | e toTheme colorError];
		hoverColor: [ :e | e toTheme colorErrorHover];
		pressedColor: [ :e | e toTheme colorError darker].
	^ formLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> dangerLabelLookIn: anElement [

	| labelLook |
	labelLook := ToLabelTextLook new.
	labelLook
		initialColor: anElement toTheme colorError;
		hoverColor: anElement toTheme colorErrorHover;
		pressedColor: anElement toTheme colorError darker.
	^ labelLook
]

{ #category : #accessing }
ToButtonType >> dashed: aBoolean [

	Error signal: 'Invalid property'.
]

{ #category : #accessing }
ToButtonType >> disabledBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  initialBg: [ :e | e toTheme colorBgContainerDisabled ];
		  yourself
]

{ #category : #accessing }
ToButtonType >> disabledBorderLookIn: anElement [

	^ ToBorderLook new
		  initialPaint: [ :e | e toTheme colorBorderDisabled ];
		  width: [ :e | e toTheme lineWidth ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> disabledFormLookIn: anElement [

	^ ToImageFormLook new
		  initialColor: [ :e | e toTheme colorBorderDisabled ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> disabledLabelLookIn: anElement [

	^ ToLabelTextLook new
		  initialColor: anElement toTheme colorTextDisabled;
		  yourself
]

{ #category : #accessing }
ToButtonType >> enabledDangerBackgroundLookIn: anElement [

	^ nil
]

{ #category : #accessing }
ToButtonType >> enabledRegularBackgroundLookIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> iconLookIn: anElement [

	^ anElement isDisabled
		  ifTrue: [ self disabledFormLookIn: anElement ]
		  ifFalse: [
			  self danger
				  ifTrue: [ self dangerFormLookIn: anElement ]
				  ifFalse: [ self regularFormLookIn: anElement ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> labelLookIn: anElement [

	^ anElement isDisabled
		  ifTrue: [ self disabledLabelLookIn: anElement ]
		  ifFalse: [
			  self danger
				  ifTrue: [ self dangerLabelLookIn: anElement ]
				  ifFalse: [ self regularLabelLookIn: anElement ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> onSkinInstalled: aSkin in: anElement [

	| borderLook backgroundLook |
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: anElement toTheme borderRadius).
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
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

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularFormLookIn: anElement [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularLabelLookIn: anElement [

	self subclassResponsibility 
]
