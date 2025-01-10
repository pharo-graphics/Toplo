Class {
	#name : #ToItemBarNodeHolder,
	#superclass : #ToBarNodeHolder,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToItemBarNodeHolder >> initializeNode [

	self dataItem presetDataDo: [ :pd |
		pd setupItem: dataItem ].
	super initializeNode 
]
