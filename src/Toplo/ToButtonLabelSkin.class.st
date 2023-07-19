Class {
	#name : #ToButtonLabelSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'buttonType'
	],
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToButtonLabelSkin >> buttonType [

	^ buttonType
]

{ #category : #accessing }
ToButtonLabelSkin >> buttonType: aButtonType [

	buttonType := aButtonType
]

{ #category : #accessing }
ToButtonLabelSkin >> textAttributesBuilderFromElement: anElement [

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
ToButtonLabelSkin >> whenAddedToSpace: anEvent in: anElement [ 

	| labelLook attrBuilder |

	attrBuilder := self textAttributesBuilderFromElement: anElement.
	labelLook := self buttonType labelLookIn: anElement.
	labelLook attrBuilder: attrBuilder.
	self addLook: labelLook.

	super whenAddedToSpace: anEvent in: anElement.

]