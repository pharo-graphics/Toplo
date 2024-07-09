Class {
	#name : #ToLabelAttributesBuilder,
	#superclass : #BlTextAttributesBuilder,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'instance creation' }
ToLabelAttributesBuilder class >> onLabel: aLabel [

	^ self new label: aLabel
]

{ #category : #accessing }
ToLabelAttributesBuilder >> attribute: aTextAttribute [
			
	(self hasAttribute: aTextAttribute)
		ifTrue: [ ^ self ].
	super attribute: aTextAttribute.
	label text attribute: aTextAttribute
]

{ #category : #accessing }
ToLabelAttributesBuilder >> label: aLabel [

	label := aLabel
]
