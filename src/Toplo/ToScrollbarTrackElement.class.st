Class {
	#name : #ToScrollbarTrackElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Core-Scrollbar'
}

{ #category : #initialization }
ToScrollbarTrackElement class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :e |
					| breadth |
					breadth := e valueOfTokenNamed: #'scrollbar-breadth'.
					e isHorizontal
						ifTrue: [ e height: breadth ]
						ifFalse: [ e width: breadth ] ] ]
]

{ #category : #configuration }
ToScrollbarTrackElement >> applyConfiguration [

	super applyConfiguration.

	self isHorizontal
		ifTrue: [
				self hMatchParent.
				self constraintsDo: [ :c | c frame vertical alignCenter ] ]
		ifFalse: [
				self vMatchParent.
				self constraintsDo: [ :c | c frame horizontal alignCenter ] ]
]

{ #category : #initialization }
ToScrollbarTrackElement >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToScrollbarTrackElement >> initialize [ 

	super initialize.
	self layout: self defaultLayout 
]
