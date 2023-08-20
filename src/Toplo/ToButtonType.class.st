Class {
	#name : #ToButtonType,
	#superclass : #Object,
	#instVars : [
		'danger'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'basic button' }
ToButtonType >> basicButtonBackgroundLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerBackgroundLookIn: anElement ]
		  ifFalse: [ self regularBackgroundLookIn: anElement ]
]

{ #category : #'basic button' }
ToButtonType >> basicButtonBorderLookIn: anElement [

	^ nil
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

{ #category : #'checkable button' }
ToButtonType >> checkableButtonBackgroundLookIn: anElement [

	^ nil
]

{ #category : #'checkable button' }
ToButtonType >> checkableButtonBorderLookIn: anElement [

	^ nil
]

{ #category : #'checkable button' }
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

{ #category : #'checkable button' }
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
ToButtonType >> toggleButtonBackgroundLookIn: anElement [

	^ nil
]

{ #category : #'toggle button' }
ToButtonType >> toggleButtonBorderLookIn: anElement [

	^ nil
]

{ #category : #'toggle button' }
ToButtonType >> toggleButtonIconSkinIn: aButton [

	^ ToToggleTrackSkin new
]

{ #category : #'toggle button' }
ToButtonType >> toggleButtonLabelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new
]
