Class {
	#name : #ToDisablementLayer,
	#superclass : #ToWidgetLayer,
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToDisablementLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self background: (Color lightGray alpha: 0.3).
]
