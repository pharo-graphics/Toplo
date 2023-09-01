Class {
	#name : #ToClickableType,
	#superclass : #Object,
	#instVars : [
		'danger'
	],
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'basic button' }
ToClickableType >> basicButtonBackgroundLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerBackgroundLookIn: anElement ]
		  ifFalse: [ self regularBackgroundLookIn: anElement ]
]

{ #category : #'basic button' }
ToClickableType >> basicButtonBorderLookIn: anElement [

	^ ToBorderLook new
]

{ #category : #'basic button' }
ToClickableType >> basicButtonIconSkinIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'basic button' }
ToClickableType >> basicButtonLabelSkinIn: anElement [

	^ self danger 
		ifTrue: [ self dangerLabelSkinIn: anElement ]
		ifFalse: [ self regularLabelSkinIn: anElement ]
]

{ #category : #'checkable button' }
ToClickableType >> checkableButtonBackgroundLookIn: anElement [

	^ ToBackgroundLook new
]

{ #category : #'checkable button' }
ToClickableType >> checkableButtonBorderLookIn: anElement [

	^ ToBorderLook new
]

{ #category : #'checkable button' }
ToClickableType >> checkableLabelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new.
]

{ #category : #'checkable button' }
ToClickableType >> checkboxIconSkinIn: aButton [

	^ ToCheckboxIconSkin new
]

{ #category : #accessing }
ToClickableType >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToClickableType >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #'api - install/uninstall  hook' }
ToClickableType >> dangerBackgroundLookIn: anElement [

	^ ToBackgroundLook new
		  disabledBg: [ :e | e toTheme colorBgContainerDisabled ];
		  initialBg: [ :e | Color transparent ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToClickableType >> dangerLabelSkinIn: anElement [

	^ ToButtonLabelSkin new type: ToLabelDangerType new 
]

{ #category : #accessing }
ToClickableType >> dashed: aBoolean [

	Error signal: 'Invalid property'.
]

{ #category : #'menu item' }
ToClickableType >> menuItemBackgroundLookIn: anElement [

	^ self danger
		  ifTrue: [ self dangerBackgroundLookIn: anElement ]
		  ifFalse: [ self regularBackgroundLookIn: anElement ]
]

{ #category : #'menu item' }
ToClickableType >> menuItemBorderLookIn: anElement [

	^ ToBorderLook new
]

{ #category : #'menu item' }
ToClickableType >> menuItemIconSkinIn: anElement [

	^ self basicButtonIconSkinIn: anElement
]

{ #category : #'menu item' }
ToClickableType >> menuItemLabelSkinIn: anElement [

	^ self basicButtonLabelSkinIn: anElement
]

{ #category : #'checkable button' }
ToClickableType >> radioButtonIconSkinIn: aButton [

	^ ToRadioButtonIconSkin new
]

{ #category : #'api - install/uninstall  hook' }
ToClickableType >> regularBackgroundLookIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToClickableType >> regularLabelSkinIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'choice box button' }
ToClickableType >> selectInnerButtonBorderLookIn: anElement [

	^ self basicButtonBorderLookIn: anElement
]

{ #category : #'choice box button' }
ToClickableType >> selectInnerButtonIconSkinIn: anElement [

	^ self basicButtonIconSkinIn: anElement
]

{ #category : #'toggle button' }
ToClickableType >> toggleButtonBackgroundLookIn: anElement [

	^ ToBackgroundLook new
]

{ #category : #'toggle button' }
ToClickableType >> toggleButtonBorderLookIn: anElement [

	^ ToBorderLook new
]

{ #category : #'toggle button' }
ToClickableType >> toggleButtonIconSkinIn: aButton [

	^ ToToggleTrackSkin new
]

{ #category : #'toggle button' }
ToClickableType >> toggleButtonLabelSkinIn: aButton [

	^ ToLabelSkin new type: ToLabelDefaultType new
]
