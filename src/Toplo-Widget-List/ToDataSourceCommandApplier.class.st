Class {
	#name : #ToDataSourceCommandApplier,
	#superclass : #ToCommandApplier,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToDataSourceCommandApplier >> command: aCommand addedIn: aSelecter [

	element isAttachedToSceneGraph ifFalse: [
		aSelecter applyCommand: aCommand.
		^ self ].
	element dataSource
		notifySelecterCommandApplicationRequest: aCommand
		from: aSelecter.
	element spaceDo: [ :sp | sp requestNextPulse ]
]
