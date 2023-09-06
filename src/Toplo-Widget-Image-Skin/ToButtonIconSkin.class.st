Class {
	#name : #ToButtonIconSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'danger'
	],
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #accessing }
ToButtonIconSkin >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonIconSkin >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> dangerFormLookIn: anElement [

	^ ToMonoColorFlatImageFormLook new
		disabledColor: [ :e | e toTheme colorImageDisabled ];
		initialColor: [ :e | e toTheme colorError];
		hoverColor: [ :e | e toTheme colorErrorHover];
		pressedColor: [ :e | e toTheme colorError darker];
		yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (self danger
			 ifTrue: [ self dangerFormLookIn: anElement ]
			 ifFalse: [ self regularFormLookIn: anElement ])
]

{ #category : #'api - install/uninstall  hook' }
ToButtonIconSkin >> regularFormLookIn: anElement [

	^ self subclassResponsibility 
]
