Class {
	#name : #ToListSelectionModelEventHandler,
	#superclass : #ToSelectionModelEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'event handling' }
ToListSelectionModelEventHandler >> appliedSelectionEvent: aSelectionEvent [

	| target |
	target := aSelectionEvent currentTarget.
	" feedback to manage selecter internal state "
	aSelectionEvent command applyOn: target selecter.
]

{ #category : #'api - accessing' }
ToListSelectionModelEventHandler >> eventsToHandle [

	^ super eventsToHandle, { ToAppliedSelectionEvent }
]
