Class {
	#name : #ToPanePlaceholderLayer,
	#superclass : #ToWidgetLayer,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #converting }
ToPanePlaceholderLayer >> asPlaceholderLayer [

	^ self
]

{ #category : #initialization }
ToPanePlaceholderLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self preventMouseEvents.

]
