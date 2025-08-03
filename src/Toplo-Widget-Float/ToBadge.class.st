Class {
	#name : #ToBadge,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeToploTheme: aTheme [

	aTheme addTokenNamed: #'badge-size' withValue: 10 asPoint
]

{ #category : #initialization }
ToBadge class >> initializeToploThemeFor: aTheme [
	<toploThemeInstaller>
	aTheme addTokenNamed: #'badge-size' withValue: 10 asPoint
]

{ #category : #'instance creation' }
ToBadge >> newRawSkin [

	^ ToBadgeSkin new
]
