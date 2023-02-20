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
			baseline: 'OnBloc'
			with: [ 
				spec repository: 'github://plantec/OnBloc/src' ];
			baseline: 'Album'
			with: [ 
				spec repository: 'github://plantec/Album/src' ].

		spec package: #Toplo with: [ 
			spec repository: 'github://plantec/Toplo/src'.
			spec requires: #( #OnBloc #Album) ].
	
		spec package: #'Toplo-Tests' with: [ 
			spec repository: 'github://plantec/Toplo/src'.
			spec requires: #( #Toplo ) ] ]
]
