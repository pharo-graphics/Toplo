Class {
	#name : #ToButtonType,
	#superclass : #Object,
	#instVars : [
		'danger'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> backgroundLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerBackgroundLookIn: anElement ]
		  ifFalse: [ self regularBackgroundLookIn: anElement ]
]

{ #category : #'basic button' }
ToButtonType >> basicButtonIconSkinIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'basic button' }
ToButtonType >> basicButtonLabelSkinIn: anElement [

	^ self danger 
		ifTrue: [ self dangerLabelSkinIn: anElement ]
		ifFalse: [ self regularLabelSkinIn: anElement ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> borderLookIn: anElement [

	^ nil
]

{ #category : #checkbox }
ToButtonType >> checkboxIconSkinIn: aButton [

	^ ToCheckboxIconSkin new
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
ToButtonType >> dangerBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> dangerLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDangerType new 
]

{ #category : #accessing }
ToButtonType >> dashed: aBoolean [

	Error signal: 'Invalid property'.
]

{ #category : #'radio button' }
ToButtonType >> radioButtonIconSkinIn: aButton [

	^ ToRadioButtonIconSkin new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularBackgroundLookIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonType >> regularLabelSkinIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'toggle button' }
ToButtonType >> toggleButtonIconSkinIn: aButton [

	^ ToToggleTrackSkin new
]

{ #category : #'toggle button' }
ToButtonType >> toggleButtonLabelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new
]
