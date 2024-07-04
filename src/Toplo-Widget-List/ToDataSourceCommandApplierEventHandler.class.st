Class {
	#name : #ToDataSourceCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToDataSourceCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	element isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent currentTarget applyCommand:
			aCommandAddedEvent command.
		^ self ].
	element dataSource
		notifySelecterCommandApplicationRequest: aCommandAddedEvent command
		from: aCommandAddedEvent currentTarget.
	element spaceDo: [ :sp | sp requestNextPulse ]
]
