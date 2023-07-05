Class {
	#name : #ToLabelLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToLabelLook >> foregroundHoverFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #accessing }
ToLabelLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorText
]

{ #category : #accessing }
ToLabelLook >> foregroundPressedFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #accessing }
ToLabelLook >> textAttributesFromElement: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToLabelLook >> textAttributesHoverFromElement: anElement [

	^ self textAttributesFromElement: anElement
]

{ #category : #accessing }
ToLabelLook >> textAttributesPressedFromElement: anElement [

	^ self textAttributesFromElement: anElement
]
