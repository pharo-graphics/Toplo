Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToPairedNodeDresser,
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installNewLabel: curr previous: prev in: anElement [

	prev ifNotNil: [ prev undress ].
	curr addDresser: (ToLabelInNodeDresser new node: anElement; yourself)
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> uninstallEventListenersIn: anElement [

	anElement label ifNotNil: [:l | l undress].
	super uninstallEventListenersIn: anElement.


]
