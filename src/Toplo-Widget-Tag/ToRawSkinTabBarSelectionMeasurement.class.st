Class {
	#name : #ToRawSkinTabBarSelectionMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#instVars : [
		'tabBar'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #api }
ToRawSkinTabBarSelectionMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	| track |
	track := tabBar userData at: #'selection-track'.
	tabBar isHorizontal
		ifTrue: [ anExtentMeasurementSpec heightSpec beExact: track height ]
		ifFalse: [ anExtentMeasurementSpec widthSpec beExact: track width ]
]

{ #category : #accessing }
ToRawSkinTabBarSelectionMeasurement >> tabBar: anObject [

	tabBar := anObject
]
