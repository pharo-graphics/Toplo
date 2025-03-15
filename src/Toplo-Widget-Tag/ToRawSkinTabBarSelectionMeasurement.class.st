Class {
	#name : #ToRawSkinTabBarSelectionMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#instVars : [
		'tabBar',
		'width'
	],
	#category : #'Toplo-Widget-Tag-Tab-RawThemeSupport'
}

{ #category : #initialization }
ToRawSkinTabBarSelectionMeasurement >> initialize [ 

	super initialize.
	width := 2.
]

{ #category : #api }
ToRawSkinTabBarSelectionMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	| track |
	track := tabBar userData at: #'selection-track' ifAbsent: [ ^ self ].
	tabBar isHorizontal
		ifTrue: [ anExtentMeasurementSpec heightSpec beExact: width]
		ifFalse: [ anExtentMeasurementSpec widthSpec beExact: width]
]

{ #category : #accessing }
ToRawSkinTabBarSelectionMeasurement >> tabBar: anObject [

	tabBar := anObject
]

{ #category : #accessing }
ToRawSkinTabBarSelectionMeasurement >> width: aNumber [

	width := aNumber
]
