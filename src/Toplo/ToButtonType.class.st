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

	^ nil
]

{ #category : #accessing }
ToButtonType >> borderLookIn: anElement [

	^ nil
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
		initialColor: anElement toTheme colorError;
		hoverColor: anElement toTheme colorErrorHover;
		pressedColor: anElement toTheme colorError darker.
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
ToButtonType >> regularFormLookIn: anElement [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularLabelLookIn: anElement [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> whenAddedToSpace: anEvent in: anElement fromSkin: aSkin [

	| borderLook backgroundLook |
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: anElement toTheme borderRadius).
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
	backgroundLook := self backgroundLookIn: anElement.
	backgroundLook ifNotNil: [ aSkin addLook: backgroundLook ].
	borderLook := self borderLookIn: anElement.
	borderLook ifNil: [ ^ self ].
	aSkin addLook: borderLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> whenRemovedFromSpace: anEvent in: anElement fromSkin: aSkin [


]
