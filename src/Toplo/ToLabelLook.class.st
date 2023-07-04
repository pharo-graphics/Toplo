Class {
	#name : #ToLabelLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToLabelLook >> foregroundFromElement: anElement [

	^ anElement toTheme colorText
]

{ #category : #accessing }
ToLabelLook >> foregroundHoverFromElement: anElement [

	^ self foregroundFromElement: anElement
]

{ #category : #accessing }
ToLabelLook >> foregroundPressedFromElement: anElement [

	^ self foregroundFromElement: anElement
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
