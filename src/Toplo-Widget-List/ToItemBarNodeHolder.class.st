Class {
	#name : #ToItemBarNodeHolder,
	#superclass : #ToBarNodeHolder,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToItemBarNodeHolder >> initializeNode [

	self dataItem presetDataDo: [ :pd |
		pd setupItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self node height: 0 ].
		^ self ].
	super initializeNode

]
