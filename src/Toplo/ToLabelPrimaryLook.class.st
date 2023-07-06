Class {
	#name : #ToLabelPrimaryLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #private }
ToLabelPrimaryLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder weight: anElement toTheme fontWeightStrong.
	builder foreground: anElement toTheme colorTextLightSolid.
	^ builder
]
