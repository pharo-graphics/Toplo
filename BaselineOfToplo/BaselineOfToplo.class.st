Class {
	#name : #BaselineOfToplo,
	#superclass : #BaselineOf,
	#category : #BaselineOfToplo
}

{ #category : #baselines }
BaselineOfToplo >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Bloc'
			with: [ 
				spec repository: 'github://plantec/bloc:dev-1.0/src' ];
			baseline: 'BlocPac'
			with: [ 
				spec repository: 'github://plantec/bloc-pac:dev-1.0/src' ].

		spec package: #Toplo with: [ 
			spec repository: 'github://plantec/Toplo/src'.
			spec requires: #( #Bloc #BlocPac ) ] ]
]
